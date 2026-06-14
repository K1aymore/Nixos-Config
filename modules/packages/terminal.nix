{ config, pkgs, ... }:

{

  config = {

    environment.sessionVariables = {
      LESSUTFCHARDEF = "F1900-F19FF:w"; # sitelen pona rendered in `less`
      EDITOR = "nvim";
    };

    home-manager.users.klaymore.programs = {
      git = {
        enable = true;
        lfs.enable = true;
        signing = {
          key = "BAE085A5C70F19F7";
          format = "openpgp";
          signByDefault = false; # don't need to sign all commits
        };
        ignores = [
          "*.swp"
          ".syncthing*"
        ];
        settings = {
          user.name = "K1aymore";
          user.email = "klaymorer@protonmail.com";

          init.defaultbranch = "main";
          push.autoSetupRemote = true;

          core.pager = "delta";
          interactive.diffFilter = "delta --color-only";
          delta = {
            navigate = true; # use n and N to move between diff sections
            light = false; # set to true if using a terminal w/ a light background color
          };
          merge.conflictstyle = "diff3";
          diff.colorMoved = "default";
          core.quotepath = false; # show hex UTF8

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
        #remux-video = "mkv";
        ignore-errors = true;
      };

      zellij = {
        enable = true;
        enableFishIntegration = false; # opens by default
        settings = {
          theme = "catppuccin-mocha";
          show_startup_tips = false;
          pane_frames = false;
        };
      };

      yazi = {
        enable = true;
        shellWrapperName = "y";
      };

      # television = {
      #   enable = true;
      #   settings = {
      #     ui.theme = "catppuccin";
      #   };
      # };

    };

  };
}
