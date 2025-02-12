{ pkgs, ... }:

{


  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;
  # https://github.com/Mic92/envfs
  services.envfs.enable = true;


  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    gcc
    gcc11
    # ghc # Haskell compiler
    # sbcl # Lisp compiler
    # nasm # assembly compiler
    # inklecate # Ink compiler/player
    gnumake
    # avalonia-ilspy # .NET exe decompiler
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
    deno # for catppuccin userstyles

    #jetbrains.idea-community
    vscode-fhs
    docker
    #arduino
    zed-editor

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
        jnoortheen.nix-ide

        redhat.java
        vscjava.vscode-java-debug

        rust-lang.rust-analyzer
        bungcip.better-toml

        #streetsidesoftware.code-spell-checker

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        roman.ayu-next
        ms-vscode.cpptools
        #ms-python.python
        #ms-python.vscode-pylance
        #ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mayukaithemevsc";
          publisher = "GulajavaMinistudio";
          version = "3.2.4";
          sha256 = "sha256-V2hAxIVu2YWonwcIG+9n300b88jzPOnKYUFt1okSX4w=";
        }
        {
          name = "vscode-scheme";
          publisher = "sjhuangx";
          version = "0.4.0";
          sha256 = "sha256-BN+C64YQ2hUw5QMiKvC7PHz3II5lEVVy0Shtt6t3ch8=";
        }
        {
          name = "vscode-sqlite";
          publisher = "alexcvzz";
          version = "0.14.1";
          sha256 = "sha256-jOQkRgBkUwJupD+cRo/KRahFRs82X3K49DySw6GlU8U=";
        }
      ];

      userSettings = {
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.colorTheme" = "Mayukai Semantic Mirage";

        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixpkgs-fmt" ];
            };
            # "options" = {
            #   # By default, this entry will be read from `import <nixpkgs> { }`.
            #   # You can write arbitary Nix expressions here, to produce valid "options" declaration result.
            #   # Tip: for flake-based configuration, utilize `builtins.getFlake`
            #   "nixos" = {
            #     "expr" = "(builtins.getFlake \"/synced/Nix/cfg\").nixosConfigurations.<name>.options";
            #   };
            #   "home-manager" = {
            #     "expr" = "(builtins.getFlake \"/synced/Nix/cfg\").homeConfigurations.<name>.options";
            #   };
            # };
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
