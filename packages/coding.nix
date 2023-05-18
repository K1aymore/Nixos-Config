{ pkgs, home-manager, ... }:

{
  imports = [ home-manager.nixosModule ];

  environment.systemPackages = with pkgs; [
    clang
    gcc
    ghc # Haskell compiler
    sbcl # Lisp compiler
    nasm # assembly compiler
    gnumake
    avalonia-ilspy # .NET exe decompiler

    nil # Nix LSP
    nixpkgs-fmt

    cargo
    rustc
    rustfmt
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

    lapce


  ];


  home-manager.users.klaymore.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions; [
      redhat.java
      vscjava.vscode-java-debug
      matklad.rust-analyzer
      jnoortheen.nix-ide
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

    userSettings = {
      "workbench.colorTheme" = "Mayukai Semantic Mirage";
      "workbench.iconTheme" = "ayu";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
        };
      };

      "git.enableCommitSigning" = true;
    };
  };



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
