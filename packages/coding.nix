{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    gcc
    gcc11
    ghc # Haskell compiler
    sbcl # Lisp compiler
    nasm # assembly compiler
    inklecate # Ink compiler/player
    gnumake
    avalonia-ilspy # .NET exe decompiler
    lldb
    valgrind


    rustup
    #cargo
    #rustc
    rustfmt
    wasm-pack # Rust WebAssembly
    rust-analyzer
    pkg-config
    xorg.libX11
    libxkbcommon
    alsa-lib


    #android-studio
    #apksigner
    jdk17
    jdk11
    jdk8
    jdt-language-server

    php

    #jetbrains.idea-community
    vscode-fhs
    docker
    #arduino

    sqlite

    /* qtcreator */
    /* libsForQt5.full */
    cmake
    gdb

    glibc_multi

    #neovide
    #neovim-qt
    #gnvim

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


  home-manager.users.klaymore.programs = {
    vscode = {
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

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        roman.ayu-next
        ms-vscode.cpptools
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
          name = "vscode-scheme";
          publisher = "sjhuangx";
          version = "0.4.0";
          sha256 = "sha256-BN+C64YQ2hUw5QMiKvC7PHz3II5lEVVy0Shtt6t3ch8=";
        }
        {
          name = "vscode-power-mode";
          publisher = "hoovercj";
          version = "3.0.2";
          sha256 = "sha256-ZE+Dlq0mwyzr4nWL9v+JG00Gllj2dYwL2r9jUPQ8umQ=";
        }
        {
          name = "subway-surfers";
          publisher = "jirkavrba";
          version = "2.0.0";
          sha256 = "sha256-gZ4dlt6T3pZgxz/voeENVVMJEJ/k99mszDXwEQzl04I=";
        }
      ];

      userSettings = {
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.colorTheme" = "Mayukai Semantic Mirage";
        
        "editor.fontFamily" = "Fira Code";
        
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
          };
        };

        "git.enableCommitSigning" = false;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 100;

        "powermode.enabled" = false; # stupid
        "powermode.combo.location" = "off";
        "powermode.combo.counterEnabled" = "hide";
        "powermode.shake.enabled" = false;
        "powermode.explosions.frequency" = 1;
        "powermode.combo.timerEnable" = "hide";
      };
    };

  };


  home-manager.users.klaymore.home.file.".sqliterc".text = ".mode column";

}
