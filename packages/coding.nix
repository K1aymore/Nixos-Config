{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  environment.systemPackages = with pkgs; [
    git
    gh

    jdk
    #jdk8
    clang
    gcc
    ghc # Haskell compiler
    sbcl  # Lisp compiler
    nasm  # assembly
    gnumake
    avalonia-ilspy  # .NET exe decompiler

    cargo
    rustc
    wasm-pack # Rust WebAssembly

    # eclipses.eclipse-java
    jetbrains.idea-community
    #vscodium-fhs
    vscode-fhs
    codeblocks
    arduino

    qtcreator
    /* libsForQt5.full */
    cmake
    gdb

    glibc_multi


    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
        ms-python.python
        ms-python.vscode-pylance
        #matklad.rust-analyzer
        #bbenoist.nix
        #ms-azuretools.vscode-docker
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        /* {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.262.0";
          sha256 = "2fb45173822221f1528a2063fb4b7fcb45ce55af74d4f8dc1623af65efe15a93";
        } */
        {
          name = "mayukaithemevsc";
          publisher = "GulajavaMinistudio";
          version = "3.2.3";
          sha256 = "a0f3c30a3d16e06c31766fbe2c746d80683b6211638b00b0753983a84fbb9dad";
        }
      ];
    })

  ];


  programs = {
    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
  users.users.klaymore.extraGroups = [ "docker" ];

}
