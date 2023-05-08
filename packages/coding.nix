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
    clang
    gcc
    ghc # Haskell compiler
    sbcl  # Lisp compiler
    nasm  # assembly compiler
    gnumake
    avalonia-ilspy  # .NET exe decompiler

    rustup
    wasm-pack # Rust WebAssembly

    jdk17
    jdk8

    #jetbrains.idea-community
    vscode-fhs
    #arduino

    /* qtcreator */
    /* libsForQt5.full */
    cmake
    gdb

    glibc_multi

    #neovide
    #neovim-qt
    #gnvim

    unstable.lapce

    # VSCodium declarative extentions
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        redhat.java
        vscjava.vscode-java-debug
        matklad.rust-analyzer
        bbenoist.nix
        #ms-vscode.cpptools
        #ms-python.python
        #ms-python.vscode-pylance
        #ms-azuretools.vscode-docker
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mayukaithemevsc";
          publisher = "GulajavaMinistudio";
          version = "3.2.3";
          sha256 = "a0f3c30a3d16e06c31766fbe2c746d80683b6211638b00b0753983a84fbb9dad";
        }
        {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.291.0";
          sha256 = "cabda0c4af2a58defa12c868b82be60109a82ed04efdca23d0829747d5fa0411";
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
