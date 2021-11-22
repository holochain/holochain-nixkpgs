{
  # Add your overlays here
  #
  sources = _: _: {
    localSources = (import ../default.nix {}).sources;
  };

  overrides = self: super: {
    toplevel = builtins.toString ./..;
    nvfetcher = (import self.localSources.nvfetcher.src).defaultPackage.x86_64-linux;
    crate2nix = (import self.localSources.crate2nix.src {});
  };

  rust-overlay = import ./rust-overlay.nix;
  rust = import ./rust.nix;
}
