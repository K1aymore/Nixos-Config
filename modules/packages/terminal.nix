{ pkgs, ... }:

{

  config = {

    home-manager.users.klaymore.programs = {

      git = {
        enable = true;
        lfs.enable = true;
        userName = "K1aymore";
        userEmail = "klaymorer@protonmail.com";
        signing = {
          key = "BAE085A5C70F19F7";
          signByDefault = false; # not needed
        };
        ignores = [
          "*.swp"
          ".syncthing*"
        ];
        extraConfig = {
          init.defaultbranch = "main";
          push.autoSetupRemote = true;

          core.pager = "delta";
          interactive.diffFilter = "delta --color-only";
          delta = {
            navigate = true; # use n and N to move between diff sections
            light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
          };
          merge.conflictstyle = "diff3";
          diff.colorMoved = "default";

        };
      };

      keychain = {
        enable = true;
      };



      helix = {
        enable = true;
        defaultEditor = false;
        #package = pkgs.evil-helix;

        settings = {
          theme = "catppuccin-mocha";
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
            color-modes = true;

            cursor-shape.insert = "bar";

            indent-guides.render = true;
          };
          keys.normal = {
            C-s = ":w";
          };
        };
      };


      neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        vimdiffAlias = true;
      };

      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };

      zoxide = {
        enable = true;
      };

      yt-dlp.settings = {
        output = "name";
        format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";
        audio-format = "best";
        embed-metadata = true;
        all-subs = true;
        embed-subs = true;
        embed-chapters = true;
        remux-video = "mkv";
        ignore-errors = true;
      };

      zellij = {
        enable = true;
        enableFishIntegration = false; # opens by default
        settings = {
          #theme = "catppuccin-mocha";
        };
      };

      yazi = {
        enable = true;
      };

      television = {
        enable = true;
        settings = {
          ui.theme = "catppuccin";
        };
      };

    };

  };
}