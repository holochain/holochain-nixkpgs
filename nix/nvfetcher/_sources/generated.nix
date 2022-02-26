# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  crate2nix = {
    pname = "crate2nix";
    version = "7178e530f7d617ac0b61a6e53c7f3b28710fb6cf";
    src = fetchFromGitHub ({
      owner = "kolloch";
      repo = "crate2nix";
      rev = "7178e530f7d617ac0b61a6e53c7f3b28710fb6cf";
      fetchSubmodules = false;
      sha256 = "sha256-d+SsMV/ysXNu5mE1qIywpQdgleEKOdsK6L4h58AoFdc=";
    });
  };
  holochain_branch_develop = {
    pname = "holochain_branch_develop";
    version = "af0a38ed90b98e78a98e0aa4a8171de8a93433c1";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "af0a38ed90b98e78a98e0aa4a8171de8a93433c1";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-LLxvZRSHkDcZPmqrONFdqbnkxP8PPmRncfRi3fNKJq4=";
    };
    cargoLock = {
      lockFile = ./holochain_branch_develop-af0a38ed90b98e78a98e0aa4a8171de8a93433c1/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  holochain_branch_main = {
    pname = "holochain_branch_main";
    version = "296a08dc25e799c6fb3da3eecafc457179d9bd59";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "296a08dc25e799c6fb3da3eecafc457179d9bd59";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-YG9OxMqP77K8VtFpM6pEsDApX/S9fivx+j9bSnvHni0=";
    };
    cargoLock = {
      lockFile = ./holochain_branch_main-296a08dc25e799c6fb3da3eecafc457179d9bd59/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  holochain_branch_staging = {
    pname = "holochain_branch_staging";
    version = "8be9fcb86655fe6edc50abeb5b52d6116906c364";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "8be9fcb86655fe6edc50abeb5b52d6116906c364";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-WApRUTphA4RWaw2GPZT+yJx+J8AVzOgfH5jkcQflfRw=";
    };
    cargoLock = {
      lockFile = ./holochain_branch_staging-8be9fcb86655fe6edc50abeb5b52d6116906c364/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  holochain_revision_holochain-0_0_110 = {
    pname = "holochain_revision_holochain-0_0_110";
    version = "holochain-0.0.110";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.110";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-XBtsT24tvZiss3tPCitP/Pl6y2eHLh7CXZCeTDV207s=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_110-holochain-0.0.110/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_115 = {
    pname = "holochain_revision_holochain-0_0_115";
    version = "holochain-0.0.115";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.115";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-O35wWoqpN8VkaPaKxbx+TcoduwUVuOJOtBfzI2Lcbpg=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_115-holochain-0.0.115/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_116 = {
    pname = "holochain_revision_holochain-0_0_116";
    version = "holochain-0.0.116";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.116";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-VNhVCoRnJfARM64cD7EpdCBtbZFe1k50k+ZakHV5dR8=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_116-holochain-0.0.116/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_117 = {
    pname = "holochain_revision_holochain-0_0_117";
    version = "holochain-0.0.117";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.117";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-O9VHSbnCFoC5FcL9uHWAUUgr23AEbNnerm1N/9vBuPc=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_117-holochain-0.0.117/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_118 = {
    pname = "holochain_revision_holochain-0_0_118";
    version = "holochain-0.0.118";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.118";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-g3zO9XTWHaP9q7D6AsEohdvLVHtZF6GzuzQg0Ez2So8=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_118-holochain-0.0.118/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_119 = {
    pname = "holochain_revision_holochain-0_0_119";
    version = "holochain-0.0.119";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.119";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-3S4zUCh1MXVaf6qCI0NlgOpiq1msobgUUTmlSPv6KzU=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_119-holochain-0.0.119/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_120 = {
    pname = "holochain_revision_holochain-0_0_120";
    version = "holochain-0.0.120";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.120";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-X16Nsjxzj38JX13jysifVOrEzB9/fZZIbe5+fEHX16k=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_120-holochain-0.0.120/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_121 = {
    pname = "holochain_revision_holochain-0_0_121";
    version = "holochain-0.0.121";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.121";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-nZEySolvpXnTz9XlR+34rn6GJM/sj3y3snqhNGvmMkM=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_121-holochain-0.0.121/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_122 = {
    pname = "holochain_revision_holochain-0_0_122";
    version = "holochain-0.0.122";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.122";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-ptTOz1CVWBPMawoYdJJKlOQqweuSrCmjcgCw7sA9VyA=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_122-holochain-0.0.122/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_123 = {
    pname = "holochain_revision_holochain-0_0_123";
    version = "holochain-0.0.123";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.123";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-xhAzh+/bUgqxXuy8aVA0uvkb+28wJ7LiyoswguP4JIQ=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_123-holochain-0.0.123/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_124 = {
    pname = "holochain_revision_holochain-0_0_124";
    version = "holochain-0.0.124";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.124";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-TIBlBVSH/oWVWEFiBbM0rklyR7Ru5aKR0A9oaVGvalU=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_124-holochain-0.0.124/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_125 = {
    pname = "holochain_revision_holochain-0_0_125";
    version = "holochain-0.0.125";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.125";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-Kj2ryH2Uwk8Ni5WNcsZMU3XRs0s21alrdWak5ZKMSYg=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_125-holochain-0.0.125/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_revision_holochain-0_0_126 = {
    pname = "holochain_revision_holochain-0_0_126";
    version = "holochain-0.0.126";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.126";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-YG9OxMqP77K8VtFpM6pEsDApX/S9fivx+j9bSnvHni0=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_126-holochain-0.0.126/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  lair_revision_v0_0_7 = {
    pname = "lair_revision_v0_0_7";
    version = "v0.0.7";
    src = fetchgit {
      url = "https://github.com/holochain/lair";
      rev = "v0.0.7";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-g9oaWJsUJT/HhxYXbpl2Ko+uZZGKk9cWBYHksEiCwYo=";
    };
    cargoLock = {
      lockFile = ./lair_revision_v0_0_7-v0.0.7/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  lair_revision_v0_0_9 = {
    pname = "lair_revision_v0_0_9";
    version = "v0.0.9";
    src = fetchgit {
      url = "https://github.com/holochain/lair";
      rev = "v0.0.9";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-glSixh2GtWtJ1wswAA0Q2hnLIFPQY+Tsh36IcUgIbRs=";
    };
    cargoLock = {
      lockFile = ./lair_revision_v0_0_9-v0.0.9/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  lair_revision_v0_1_0 = {
    pname = "lair_revision_v0_1_0";
    version = "v0.1.0";
    src = fetchgit {
      url = "https://github.com/holochain/lair";
      rev = "v0.1.0";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-EWtc9+KcN/RHOg5N4wCLBXRppXheda5uubwrQVojc0s=";
    };
    cargoLock = {
      lockFile = ./lair_revision_v0_1_0-v0.1.0/Cargo.lock;
      outputHashes = {
        
      };
    };
  };
  nixpkgs = {
    pname = "nixpkgs";
    version = "c8c5faff75fd017e468e8733312525b51cea1af2";
    src = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/c8c5faff75fd017e468e8733312525b51cea1af2.tar.gz";
      sha256 = "19s4bb4qnkgind2fdrv4q942l4avjvbqf1g4czg14d8smq781bbw";
    };
  };
  nvfetcher = {
    pname = "nvfetcher";
    version = "6bd24e64192add7778a523686ab1dac3fdac05c0";
    src = fetchFromGitHub ({
      owner = "berberman";
      repo = "nvfetcher";
      rev = "6bd24e64192add7778a523686ab1dac3fdac05c0";
      fetchSubmodules = false;
      sha256 = "sha256-d/0RIOJyArefrxRcGT4RFFRa6zWCo2WxebtLE5UToRg=";
    });
  };
  rust-overlay = {
    pname = "rust-overlay";
    version = "b4532ea48564cd25534203b78dc54cc6327e0658";
    src = fetchgit {
      url = "https://github.com/oxalica/rust-overlay";
      rev = "b4532ea48564cd25534203b78dc54cc6327e0658";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-EB3Xw30GnqhEdezEWlPy8XYsZaNDu9hScwVbI7/busA=";
    };
  };
}
