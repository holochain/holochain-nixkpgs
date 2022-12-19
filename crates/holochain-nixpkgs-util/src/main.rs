use clap::{Parser, Subcommand};

/// Simple program to greet a person
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
struct CliArgs {
    /// Number of times to greet
    #[clap(short, long, default_value_t = 1)]
    verbose: u8,

    /// Name of the person to greet
    #[clap(subcommand)]
    cmd: Cmd,
}

#[derive(Debug, Subcommand)]
enum Cmd {
    UpdateHolochainTags(update_holochain_tags::CmdArgs),
}

#[tokio::main]
async fn main() {
    let cli_args = CliArgs::parse();

    match &cli_args.cmd {
        Cmd::UpdateHolochainTags(cmd_args) => update_holochain_tags::cmd(&cli_args, cmd_args).await,
    }
    .unwrap()
}

pub(crate) mod git_helper {
    use std::io::BufRead;

    use anyhow::bail;
    use cargo_lock::Lockfile;

    pub(crate) async fn ls_remote_tags(
        url: &str,
        glob_filter: &str,
    ) -> anyhow::Result<Vec<String>> {
        let mut cmd = std::process::Command::new("git");
        cmd.args(&["ls-remote", "--tags", "--refs", url, glob_filter]);

        let output = cmd.output()?;

        if !output.status.success() {
            bail!("running {:#?} failed:\n{:#?}", cmd, output);
        }

        // looks something like this
        // 6535292238dc1fbd2b60433a2054f7787e4f060e	refs/tags/holochain-0.0.102
        // (...)
        // c77901e614e653adaa17e80b41db67f8a4fa5b88	refs/tags/holochain-0.0.127
        let lines = output
            .stdout
            .lines()
            .filter_map(|l| l.ok())
            .filter_map(|l| -> Option<String> {
                l.split("\t")
                    .last()
                    .map(|s| s.replace("refs/tags/", "").to_string())
            })
            .collect();

        Ok(lines)
    }

    /// wrapper around "git diff --quiet" that returns true if the given pathspec changed in the working directory.
    pub(crate) async fn pathspec_has_diff(pathspec: &str) -> anyhow::Result<bool> {
        let mut cmd = std::process::Command::new("git");
        cmd.args(&["diff", "--quiet", "--", pathspec]);

        let output = cmd.output()?;

        match output
            .status
            .code()
            .ok_or_else(|| anyhow::anyhow!("cmd exited without a status code"))?
        {
            0 => Ok(false),
            1 => Ok(true),
            _ => {
                bail!("running {:#?} failed:\n{:#?}", cmd, output);
            }
        }
    }
}

mod update_holochain_tags {

    use std::{
        collections::{BTreeMap, HashSet},
        env::temp_dir,
        fs::{File, OpenOptions},
        io::{Read, Seek, SeekFrom, Write},
        os::unix::prelude::FileExt,
        path::PathBuf,
        process::{Command, ExitStatus},
    };

    use anyhow::bail;
    use cargo_lock::Lockfile;
    use crates_index_helper::Fallible;
    use itertools::Itertools;
    use linked_hash_map::LinkedHashMap;
    use linked_hash_set::LinkedHashSet;
    use semver::{Version, VersionReq};
    use toml_edit::Document;
    use update_holochain_versions::{
        nvfetcher::{BinCrateSource, NvfetcherWrapper},
        update_config::{GitSrc, UpdateConfigEntry},
    };

    #[derive(clap::Args, Debug)]
    pub(crate) struct CmdArgs {
        #[clap(long)]
        dry_run: bool,

        #[clap(long, default_value_t = 10)]
        keep_tags: u8,

        #[clap(long, default_value = ".github/workflows/build.yml")]
        build_yaml_path: PathBuf,

        #[clap(long, default_value = "packages/holochain/versions/update_config.toml")]
        update_config_toml_path: PathBuf,

        #[clap(long, default_value = "https://github.com/holochain/holochain.git")]
        holochain_git_url: String,
    }

    fn latest_non_compatible_versions(all_versions: Vec<Version>) -> HashSet<Version> {
        // Filter all the tags to collect only
        let mut latest_versions: HashSet<Version> = HashSet::new();

        for version in all_versions.clone() {
            let mut found = false;
            let mut inserted = false;
            for existing_version in latest_versions.clone() {
                let existing_version_requirement =
                    VersionReq::parse(existing_version.to_string().as_str())
                        .expect("Cannot convert Version to VersionReq");

                if existing_version_requirement.matches(&version) {
                    found = true;
                    if version > existing_version {
                        inserted = true;
                        latest_versions.remove(&existing_version);
                        latest_versions.insert(version.clone());
                    }
                }
            }
            if !found && !inserted {
                latest_versions.insert(version.clone());
            }
        }

        latest_versions
    }

    fn read_holochain_revision(nvfetcher_tooling: &NvfetcherWrapper) -> anyhow::Result<Version> {
        let tmpdir = temp_dir();
        nvfetcher_tooling.fetch_and_regen_srcinfo()?;
        let import_fn = r#"
{ generated ? ./_sources/generated.nix }:
let
  _nixpkgs = (import ./_sources/generated.nix {
    fetchgit = null;
    fetchurl = null;
    fetchFromGitHub = null;
  }).nixpkgs.src;
  nixpkgs = import _nixpkgs { };
in
nixpkgs.callPackage generated { }
"#;
        let sources_fn_path = nvfetcher_tooling.nvfetcher_dir.join("sources.nix");
        std::fs::write(&sources_fn_path, import_fn)?;

        let tooling_generated_path = nvfetcher_tooling
            .nvfetcher_dir
            .join("_sources/generated.nix");

        let tooling_src_path = tmpdir.join("tooling_src_path");

        let mut src_path_cmd = Command::new("nix");

        src_path_cmd.args(&[
            "build",
            "-f",
            &sources_fn_path.to_string_lossy(),
            "--argstr",
            "generated",
            &tooling_generated_path.to_string_lossy(),
            "-o",
            &tooling_src_path.to_string_lossy(),
            &nvfetcher_tooling.src.crate_toml_key(),
        ]);

        eprintln!("running {:#?}", &src_path_cmd);

        let child = src_path_cmd.spawn()?;
        let output = child.wait_with_output()?;
        if !ExitStatus::success(&output.status) {
            bail!("{:?}", output);
        }

        let tooling_cargo_lock_path = tooling_src_path.join("Cargo.lock");

        let lockfile = Lockfile::load(&tooling_cargo_lock_path)?;
        eprintln!("number of dependencies: {}", lockfile.packages.len());

        const PACKAGE_OF_INTEREST: &str = "holochain";

        let package = lockfile
            .packages
            .iter()
            .find(|p| p.name.as_str() == PACKAGE_OF_INTEREST)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "couldn't find {} matching in {:?}",
                    PACKAGE_OF_INTEREST,
                    tooling_cargo_lock_path.display(),
                )
            })?;

        Ok(package.version.clone())
    }

    async fn add_tooling_versions(
        update_config_toml_entries: &mut LinkedHashMap<String, UpdateConfigEntry>,
        git_url: &String,
        crate_name: &String,
    ) -> anyhow::Result<()> {
        let mut holochain_version_for_tooling_version: BTreeMap<semver::Version, semver::Version> =
            BTreeMap::new();

        let tags = crate::git_helper::ls_remote_tags(git_url, &format!("v*")).await?;

        let versions: Vec<Version> = tags
            .into_iter()
            .filter_map(|t| t.strip_prefix("v").map(|s| s.to_string()))
            .filter_map(|s| Version::parse(s.as_str()).ok())
            .collect();

        for version in versions {
            // Download the cargo.lock for that tag
            let nvfetcher_tooling = NvfetcherWrapper::new(
                BinCrateSource {
                    name: crate_name.as_str(),
                    git_repo: git_url.as_str(),
                    git_src: GitSrc::Revision(format!("v{}", version)),
                    bins_filter: Default::default(),
                },
                None,
                None,
            )?;
            // Get the holochain version for that tag
            let holochain_version = read_holochain_revision(&nvfetcher_tooling)?;

            holochain_version_for_tooling_version.insert(version, holochain_version);
        }

        for (tag, entry) in update_config_toml_entries {
            let holochain_version_str = tag.replace("v", "").replace("_", ".");
            if let Ok(holochain_version) = Version::parse(holochain_version_str.as_str()) {
                // Get the highest matching tooling version for this holochain version
                let mut highest: Option<Version> = None;

                for (tooling_version, holochain_version_for_tooling) in
                    holochain_version_for_tooling_version.iter()
                {
                    let version_req =
                        VersionReq::parse(holochain_version_for_tooling.to_string().as_str())
                            .expect("Can't convert from Version to VersionReq");
                    if version_req.matches(&holochain_version) {
                        if let Some(h) = &highest {
                            if tooling_version > h {
                                highest = Some(tooling_version.clone());
                            }
                        } else {
                            highest = Some(tooling_version.clone());
                        }
                    }
                }

                entry.scaffolding_version = highest;
            }
        }

        Ok(())
    }

    async fn add_scaffolding_versions(
        update_config_toml_entries: &mut LinkedHashMap<String, UpdateConfigEntry>,
    ) -> anyhow::Result<()> {
        add_tooling_versions(
            update_config_toml_entries,
            &String::from("https://github.com/holochain/scaffolding"),
            &String::from("holochain_scaffolding_cli"),
        )
        .await
    }

    pub(crate) async fn cmd(_cli_args: &super::CliArgs, cmd_args: &CmdArgs) -> anyhow::Result<()> {
        const TAG_GLOB_PREFIX: &str = "holochain-";

        // gather existing state from the config file
        let mut update_config_toml = OpenOptions::new()
            .create(true)
            .write(true)
            .read(true)
            .open(&cmd_args.update_config_toml_path)?;

        let mut update_config_toml_entries = {
            let mut buf = String::new();
            update_config_toml.read_to_string(&mut buf)?;
            let doc = buf.parse::<toml_edit::Document>()?;

            doc.iter()
                .map(|(key, item)| {
                    Ok((
                        key.to_string(),
                        toml_edit::de::from_item::<UpdateConfigEntry>(item.clone().clone())?,
                    ))
                })
                .try_collect::<_, LinkedHashMap<_, _>, anyhow::Error>()?
        };

        let mut added_entries_update_config = LinkedHashSet::new();

        // process the upstream tags from the holochain repo
        for tag in crate::git_helper::ls_remote_tags(
            &cmd_args.holochain_git_url,
            &format!("{}*", TAG_GLOB_PREFIX),
        )
        .await?
        {
            let entry_key = format!("v{}", tag.replace(TAG_GLOB_PREFIX, "").replace(".", "_"));

            let entry = update_config_toml_entries
                .entry(entry_key.clone())
                .or_insert_with(|| {
                    added_entries_update_config.insert(entry_key);

                    UpdateConfigEntry {
                        git_src: GitSrc::Revision(tag.clone()),

                        ..Default::default()
                    }
                });

            // evaluate whether or not this tag has been published
            let published = crates_index_helper::is_version_published(
                "holochain",
                &semver::Version::parse(&tag.replace("holochain-", ""))?,
                false,
            )?;

            if !published {
                println!(
                    "warning: marking tag {} as broken as it has not been published",
                    &tag
                );
                entry.broken = Some(true);
            }
        }

        let (removed_entries_build_yml, added_entries_build_yml) =
            update_build_yml(&cmd_args, &update_config_toml_entries)?;

        if added_entries_build_yml != added_entries_update_config {
            println!(
                "warning: symmetric difference between build.yml and update_config.toml: {:#?}",
                added_entries_build_yml.symmetric_difference(&added_entries_update_config)
            );
        }

        add_scaffolding_versions(&mut update_config_toml_entries).await?;

        rewrite_update_config(cmd_args, update_config_toml, &update_config_toml_entries)?;

        let update_config_toml_pathstr = cmd_args
            .update_config_toml_path
            .as_os_str()
            .to_string_lossy()
            .to_string();
        let update_config_changed =
            crate::git_helper::pathspec_has_diff(&update_config_toml_pathstr).await?;

        let build_yml_pathstr = cmd_args
            .build_yaml_path
            .as_os_str()
            .to_string_lossy()
            .to_string();
        let build_yml_changed =
            crate::git_helper::pathspec_has_diff(&update_config_toml_pathstr).await?;

        let msg = indoc::formatdoc!(
            r#"update holochain tags

            {}:

            changed: {}
            added ({}): {:#?}


            {}:

            changed: {}
            removed ({}): {:#?}
            added ({}): {:#?}
            "#,
            &update_config_toml_pathstr,
            update_config_changed,
            &added_entries_update_config.len(),
            &added_entries_update_config,
            &build_yml_pathstr,
            build_yml_changed,
            &removed_entries_build_yml.len(),
            &removed_entries_build_yml,
            &added_entries_build_yml.len(),
            &added_entries_build_yml,
        );

        println!("{}", msg);

        if removed_entries_build_yml.is_empty()
            && added_entries_build_yml.is_empty()
            && added_entries_update_config.is_empty()
            && !update_config_changed
        {
            return Ok(());
        }

        // commit the config files
        {
            let mut cmd = std::process::Command::new("git");
            cmd.args(&[
                "commit",
                "-F",
                "-",
                &cmd_args
                    .build_yaml_path
                    .as_os_str()
                    .to_string_lossy()
                    .to_string(),
                &cmd_args
                    .update_config_toml_path
                    .as_os_str()
                    .to_string_lossy()
                    .to_string(),
            ])
            .stdin(std::process::Stdio::piped());

            println!(
                "{}running command: {:?}",
                if cmd_args.dry_run { "[DRY_RUN] " } else { "" },
                cmd
            );

            if !cmd_args.dry_run {
                let mut child = cmd.spawn()?;
                let mut stdin = child.stdin.take().expect("could not open child's stdin");
                std::thread::spawn(move || {
                    stdin
                        .write_all(msg.as_bytes())
                        .expect("Failed to write commit msg to stdin");
                });
                let output = child.wait_with_output()?;
                if !output.status.success() {
                    bail!("running {:#?} failed:\n{:#?}", cmd, output);
                }
            } else {
                println!(
                    "[DRY_RUN] would add these entries to the update_config.toml:\n{:#?}",
                    added_entries_update_config
                        .iter()
                        .map(|entry_key| update_config_toml_entries.get(entry_key).unwrap())
                        .collect::<Vec<_>>()
                );
            }
        }

        // generate the version files for the newly added tags
        for entry_key in added_entries_update_config {
            let mut cmd = std::process::Command::new("hnixpkgs-update-single");
            cmd.arg(&entry_key);

            println!(
                "{}running command: {:?}",
                if cmd_args.dry_run { "[DRY_RUN] " } else { "" },
                cmd
            );

            if !cmd_args.dry_run {
                let output = cmd.output()?;
                if !output.status.success() {
                    println!("running command {:#?} failed:\n{:#?}", cmd, output);
                }
            }
        }

        Ok(())
    }

    // make sure the latest upstream tags exist in the build.yml
    fn update_build_yml(
        cmd_args: &CmdArgs,
        update_config_toml_entries: &LinkedHashMap<String, UpdateConfigEntry>,
    ) -> anyhow::Result<(LinkedHashSet<String>, LinkedHashSet<String>)> {
        let mut build_yaml: serde_yaml::Value =
            serde_yaml::from_reader(&std::fs::File::open(&cmd_args.build_yaml_path)?)?;

        let mut nix_attributes = &mut build_yaml;
        for attr in [
            "jobs",
            "holochain-binaries",
            "strategy",
            "matrix",
            "nixAttribute",
        ] {
            nix_attributes = nix_attributes
                .get_mut(&attr)
                .ok_or_else(|| anyhow::anyhow!("can't access {}", attr))?;
        }
        let nix_attributes = nix_attributes
            .as_sequence_mut()
            .ok_or_else(|| anyhow::anyhow!("nix_attributes is not a sequence"))?;

        let entries_orig = HashSet::<serde_yaml::Value>::from_iter(nix_attributes.iter().cloned());

        println!("nix_attributes: {:?}", nix_attributes);

        // keep only a limited number of entries. treat the ones tarting with `v[0-9]` as replacable
        let prefix_re = regex::Regex::new("^v[0-9]+")?;
        nix_attributes.retain(|value| match value {
            serde_yaml::Value::String(s) => !prefix_re.is_match(s),
            other => panic!("unexpected entry in nix_attributes: {:?}", other),
        });
        let intact_revision_entries = update_config_toml_entries
            .iter()
            .filter(|(_, entry)| {
                if entry.broken.unwrap_or_default() {
                    false
                } else {
                    entry.git_src.is_rev()
                }
            })
            .map(|(entry_key, _)| entry_key)
            .cloned()
            .collect::<Vec<_>>();

        let skip =
            intact_revision_entries.len() - (cmd_args.keep_tags as usize - nix_attributes.len());
        for entry_keys in intact_revision_entries.into_iter().skip(skip) {
            nix_attributes.push(serde_yaml::Value::String(entry_keys));
        }

        let entries_new = HashSet::<serde_yaml::Value>::from_iter(nix_attributes.iter().cloned());

        anyhow::ensure!(cmd_args.keep_tags as usize >= nix_attributes.len());

        println!("new nix_attributes:\n{:?}", nix_attributes);

        let build_yaml_content = {
            let mut output = vec![];
            serde_yaml::to_writer(&mut output, &build_yaml)?;
            String::from_utf8(output)?
        };

        println!("new file content:\n{}", &build_yaml_content);

        if !cmd_args.dry_run {
            std::fs::File::create(&cmd_args.build_yaml_path)?
                .write_all_at(build_yaml_content.as_bytes(), 0)?;
        }

        Ok((
            entries_orig
                .difference(&entries_new)
                .map(|v| v.as_str().unwrap().to_string())
                .collect::<LinkedHashSet<_>>(),
            entries_new
                .difference(&entries_orig)
                .map(|v| v.as_str().unwrap().to_string())
                .collect::<LinkedHashSet<_>>(),
        ))
    }

    // write back the given entries to update_config.toml
    fn rewrite_update_config<'a>(
        cmd_args: &CmdArgs,
        mut update_config_toml: File,
        update_config_toml_entries: &LinkedHashMap<String, UpdateConfigEntry>,
    ) -> anyhow::Result<()> {
        let mut document = Document::new();

        for (entry_key, entry) in update_config_toml_entries {
            let doc = toml_edit::easy::to_document(&entry)?;
            let table = doc.as_table();
            let item = toml_edit::Item::Table(table.clone());

            document.insert(&entry_key, item);
        }

        let update_config_toml_string = document.to_string();
        let update_config_toml_bytes = update_config_toml_string.as_bytes();

        if !cmd_args.dry_run {
            update_config_toml.seek(SeekFrom::Start(0))?;
            update_config_toml.write_all(&update_config_toml_bytes)?;
            update_config_toml.set_len(update_config_toml_bytes.len() as u64)?;
        }

        Ok(())
    }

    #[cfg(test)]
    mod tests {
        use std::collections::HashSet;

        use semver::Version;

        use crate::update_holochain_tags::latest_non_compatible_versions;

        #[test]
        fn latest_non_compatible_versions_works() {
            assert_eq!(
                latest_non_compatible_versions(vec![
                    Version::parse("0.0.1").unwrap(),
                    Version::parse("0.0.2").unwrap(),
                    Version::parse("0.1.0").unwrap(),
                    Version::parse("0.1.1").unwrap()
                ]),
                HashSet::from([
                    Version::parse("0.0.1").unwrap(),
                    Version::parse("0.0.2").unwrap(),
                    Version::parse("0.1.1").unwrap()
                ])
            );
        }
    }
}
