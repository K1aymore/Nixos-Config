{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.vscode.enable {
    home-manager.users.klaymore.programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
    home-manager.users.klaymore.programs.vscode.profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide

        #redhat.java
        #vscjava.vscode-java-debug

        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        # Not allowed in VSCodium
        # visualstudiotoolsforunity.vstuc
        # ms-dotnettools.vscode-dotnet-runtime
        # ms-dotnettools.vscodeintellicode-csharp
        # ms-dotnettools.csdevkit
        # ms-dotnettools.csharp

        #streetsidesoftware.code-spell-checker

        #catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        #roman.ayu-next
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
        # {
        #   name = "vscode-scheme";
        #   publisher = "sjhuangx";
        #   version = "0.4.0";
        #   sha256 = "sha256-BN+C64YQ2hUw5QMiKvC7PHz3II5lEVVy0Shtt6t3ch8=";
        # }
        # {
        #   name = "vscode-sqlite";
        #   publisher = "alexcvzz";
        #   version = "0.14.1";
        #   sha256 = "sha256-jOQkRgBkUwJupD+cRo/KRahFRs82X3K49DySw6GlU8U=";
        # }
      ];

      userSettings = {
        "window.newWindowProfile" = "Default";
        "workbench.iconTheme" = "catppuccin-mocha";
        #"workbench.colorTheme" = "Mayukai Semantic Mirage";

        "editor.fontFamily" = "Fira Code, Fairfax Hax HD, nasin nanpa, sitelen seli kiwen asuki, Twemoji Country Flags, monospace";
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
        "update.showReleaseNotes" = false;

        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 100;
        "[markdown]" = {
          "editor.wordWrap" = "bounded";
        };

        "powermode.enabled" = false; # stupid
        "powermode.combo.location" = "off";
        "powermode.combo.counterEnabled" = "hide";
        "powermode.shake.enabled" = false;
        "powermode.explosions.frequency" = 1;
        "powermode.combo.timerEnable" = "hide";
      };
    };

  };
}