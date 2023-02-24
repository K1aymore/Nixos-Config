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
    nasm  # assembly
    gnumake
    avalonia-ilspy  # .NET exe decompiler

    cargo
    rustc
    wasm-pack # Rust WebAssembly

    # eclipses.eclipse-java
    #jetbrains.idea-community
    vscode-fhs
    #codeblocks
    arduino

    /* qtcreator */
    /* libsForQt5.full */
    cmake
    gdb

    glibc_multi

    neovide
    neovim-qt
    gnvim
    

    # VSCodium declarative extentions
    /*(vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
        #ms-python.python
        #ms-python.vscode-pylance
        #matklad.rust-analyzer
        #bbenoist.nix
        #ms-azuretools.vscode-docker
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mayukaithemevsc";
          publisher = "GulajavaMinistudio";
          version = "3.2.3";
          sha256 = "a0f3c30a3d16e06c31766fbe2c746d80683b6211638b00b0753983a84fbb9dad";
        }
      ];
    })*/

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
