{ config, pkgs, ... }:

{

  config = {

    environment.sessionVariables = {
      LESSUTFCHARDEF = "F1900-F19FF:w"; # sitelen pona rendered in `less`
      EDITOR = "nvim";
    };



    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        git.enable = true;
        lsp = {
          enable = true;
          inlayHints.enable = true;
        };
        languages = {
          enableTreesitter = false; # default false
          nix.enable = true;
          rust.enable = true;
          clang.enable = true;
          #csharp.enable = true;
          bash.enable = true;
          markdown.enable = true;
          html.enable = true;
          css.enable = true;
          ts.enable = true;
          yaml.enable = true;
        };
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        telescope.enable = true;
        mini.pick.enable = true;
        fzf-lua.enable = true;
        autocomplete.nvim-cmp.enable = true;
        filetree.neo-tree.enable = true;
        filetree.neo-tree.setupOpts.auto_clean_after_session_restore = true;
        #filetree.nvimTree.enable = true; # opens automatically

        visuals = {
          indent-blankline.enable = true;
          rainbow-delimiters.enable = true;
        };

        keymaps = [
          {
            key = "<C-BS>";
            mode = [ "n" "c" "v" ];
            action = "ldb";
            desc = "Delete previous word";
            silent = false;
          }
          {
            key = "<C-BS>";
            mode = [ "i" ];
            action = "<ESC>ldbi";
            desc = "Delete previous word";
            silent = false;
          }

          { # ctrl+s for save
            key = "<C-s>";
            mode = [ "n" "v" ];
            action = ":w<Enter>";
            desc = "Save file";
            silent = false;
          }
          {
            key = "<C-s>";
            mode = [ "i" ];
            action = "<ESC>:w<Enter>i";
            desc = "Save file";
            silent = false;
          }

          {
            key = "<C-S-U>";
            mode = [ "i" ];
            action = "<C-v>U";
            desc = "Insert Unicode character";
            silent = false;
          }
        ];

        options = {
          number = true;
          relativenumber = true;
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;

          guifont = "${config.klaymore.font.monospace},Fira Code,nasin-nanpa:h${toString config.klaymore.font.size}";
        };
        
        
        luaConfigPost = ''
          vim.cmd [[
            autocmd VimEnter * if getcwd() == '/home/klaymore' | cd ${config.klaymore.configPath} | endif
          ]]

          -- sitelen pona correct width
          vim.fn.setcellwidths({ {0xF1900, 0xF19FF, 2}, })


          -- Neovide settings
          --vim.g.neovide_fullscreen = true
          vim.g.neovide_cursor_trail_size = 0.4
          vim.g.neovide_cursor_animation_length = 0.08
          vim.g.neovide_cursor_short_animation_length = 0
          vim.g.neovide_scroll_animation_length = 0.13
          vim.g.neovide_input_ime = true
          vim.g.neovide_cursor_hack = false
        '';
      };
    };


    home-manager.users.klaymore.programs = {

      git = {
        enable = true;
        lfs.enable = true;
        signing = {
          key = "BAE085A5C70F19F7";
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
