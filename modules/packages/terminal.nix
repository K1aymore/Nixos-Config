{ pkgs, ... }:

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
          csharp.enable = true;
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

        visuals = {
          indent-blankline.enable = true;
          rainbow-delimiters.enable = true;
        };

        keymaps = [
          # ctrl+s for save
        ];

        options = {
          number = true;
          relativenumber = true;
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;

          guifont = "Fira Code,Fairfax Hax HD:h10";
        };
        
        
        luaConfigPost = ''

          -- sitelen pona correct width
          vim.fn.setcellwidths({ {0xF1900, 0xF19FF, 2}, })


          -- Neovide settings
          vim.g.neovide_fullscreen = true
          vim.g.neovide_cursor_trail_size = 0.4
          vim.g.neovide_cursor_animation_length = 0.09
          vim.g.neovide_scroll_animation_length = 0.13
        '';
      };
    };


    home-manager.users.klaymore.programs = {

      git = {
        enable = true;
        lfs.enable = true;
        userName = "K1aymore";
        userEmail = "klaymorer@protonmail.com";
        signing = {
          key = "BAE085A5C70F19F7";
          signByDefault = false; # don't need to sign all commits
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


      # neovim = {
      #   enable = true;
      #   defaultEditor = true;
      #   vimAlias = true;
      #   viAlias = true;
      #   vimdiffAlias = true;

      #   extraLuaPackages = ps: [
      #     ps.magick
      #   ];
      #   extraPackages = [
      #     pkgs.ueberzugpp
      #     pkgs.imagemagick
      #   ];

      #   #coc.enable = true;
      #   #nvim-treesitter.withAllGrammars
      #   # nerdtree ultisnips vimproc slimv tagbar vim-surround vim-airline haskell-vim vim-parinfer
      #   plugins = with pkgs.vimPlugins; [
      #     #indentLine
      #     rainbow #YouCompleteMe
      #     #minimap-vim
      #     vim-fugitive #ale

      #     nvim-autopairs
      #     neoformat
      #     vim-nix
      #     #rust-vim
      #     leap-nvim
      #     coc-rust-analyzer

      #     vim-lsp

      #     catppuccin-nvim
      #   ];

      #   extraConfig = ''
      #     syntax on
      #     set number
      #     set relativenumber

      #     let g:rainbow_active = 1

      #     "set expandtab  " spaces instead of tabs
      #     set tabstop=2
      #     set shiftwidth=2
      #     set softtabstop=2
      #     "set colorcolumn=80
      #     filetype plugin indent on
      #     "set list lcs=tab:\·\

      #     set mouse=a
      #     set mousehide

      #     set splitright
      #     set splitbelow

      #     autocmd Filetype json
      #       \ let g:indentLine_setConceal = 0

      #     let g:paredit_electric_return=0
      #     let g:paredit_disable_ftindent=1

      #     " sitelen pona correct width
      #     call setcellwidths([
      #           \ [0xF1900, 0xF19FF, 2],
      #           \ ])
      #     colorscheme catppuccin-mocha

      #     set guifont=Fira\ Code,Fairfax\ Hax\ HD:h10

      #     " Neovide settings
      #     if exists("g:neovide")
      #       let g:neovide_fullscreen = v:true
      #       let g:neovide_cursor_trail_size = 0.4
      #       let g:neovide_cursor_animation_length = 0.09
      #       let g:neovide_scroll_animation_length = 0.12
      #     endif
      #   '';
      # };


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
        enableFishIntegration = true; # opens by default
        settings = {
          theme = "catppuccin-mocha";
          show_startup_tips = false;
          pane_frames = false;
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
