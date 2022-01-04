# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  crate2nix = {
    pname = "crate2nix";
    version = "ed9c5c9045c32031e766f6b64f6996b77eeac4fa";
    src = fetchFromGitHub ({
      owner = "kolloch";
      repo = "crate2nix";
      rev = "ed9c5c9045c32031e766f6b64f6996b77eeac4fa";
      fetchSubmodules = false;
      sha256 = "sha256-ObCY61R52AJ4oDGipjBnzu19cP0PIWetRPx1tbTzxNI=";
    });
  };
  holochain_branch_develop = {
    pname = "holochain_branch_develop";
    version = "f4b3a94d027a73a693eef511c8a5177373a04364";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "f4b3a94d027a73a693eef511c8a5177373a04364";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-4MpKK7QqqqFsomHh/XVtYMyoA3AnB45qVDhdh4H5ngA=";
    };
    cargoLock = {
      lockFile = ./holochain_branch_develop-f4b3a94d027a73a693eef511c8a5177373a04364/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
      };
    };
  };
  holochain_branch_main = {
    pname = "holochain_branch_main";
    version = "77ebba75f48fe86e98f14a4fe3bfdd306bad5cfb";
    src = fetchgit {
      url = "https://github.com/holochain/holochain";
      rev = "77ebba75f48fe86e98f14a4fe3bfdd306bad5cfb";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-nZEySolvpXnTz9XlR+34rn6GJM/sj3y3snqhNGvmMkM=";
    };
    cargoLock = {
      lockFile = ./holochain_branch_main-77ebba75f48fe86e98f14a4fe3bfdd306bad5cfb/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
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
      sha256 = "sha256-3udcqyCkpGbJYDc0rxBND7gpV/XAKR8e7WyhEThVaUE=";
    };
    cargoLock = {
      lockFile = ./holochain_revision_holochain-0_0_122-holochain-0.0.122/Cargo.lock;
      outputHashes = {
        "cargo-test-macro-0.1.0" = "sha256-hIGpT0n41CA24vss4itXS3O2XrznsBce/60PUVrwwfs=";
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
    version = "e359d31cb93028a28ca1e595c2a5672ba6920808";
    src = fetchFromGitHub ({
      owner = "nixos";
      repo = "nixpkgs";
      rev = "e359d31cb93028a28ca1e595c2a5672ba6920808";
      fetchSubmodules = false;
      sha256 = "sha256-lSp/czUAdAjl//Cun8nz5LdAAb4e2xL4nzHp+BFngU8=";
    });
  };
  nvfetcher = {
    pname = "nvfetcher";
    version = "8aedc71c67960945bc18fb1077e7bdcd9046f1ee";
    src = fetchFromGitHub ({
      owner = "berberman";
      repo = "nvfetcher";
      rev = "8aedc71c67960945bc18fb1077e7bdcd9046f1ee";
      fetchSubmodules = false;
      sha256 = "sha256-jxquDPaIJPub49c1UK96LHlFTzSCXCJ6Mv5fpeGtD90=";
    });
  };
  rust-overlay = {
    pname = "rust-overlay";
    version = "d453c844766d33c68812a7410b7ebebe350e795e";
    src = fetchgit {
      url = "https://github.com/oxalica/rust-overlay";
      rev = "d453c844766d33c68812a7410b7ebebe350e795e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-WRHtvq6mpuOtkzakwrigBRrD4UVVwUCb09tlxF0fNyI=";
    };
  };
}
