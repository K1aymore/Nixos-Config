{ pkgs, ... }:

{

  programs = {
    wireshark.enable = true;
    nix-ld.enable = true;
  };


  home-manager.users.klaymore.programs = {
    home-manager.enable = true;

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

      settings = {
        theme = "ayu_mirage";
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
      defaultEditor = false;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      coc.enable = true;
      #nvim-treesitter.withAllGrammars
      # nerdtree ultisnips vimproc slimv tagbar vim-surround vim-airline haskell-vim vim-parinfer
      plugins = with pkgs.vimPlugins; [
        indentLine
        rainbow #YouCompleteMe
        #minimap-vim
        vim-fugitive #ale nvim-autopairs
        neoformat
        vim-nix
        #rust-vim
        leap-nvim
        coc-rust-analyzer

        #catppuccin-nvim # broken
        neovim-ayu
        tokyonight-nvim
        nightfox-nvim
        onedark-nvim
        onedarkpro-nvim
        # vim-monokai-tasty vim-monokai vim-monokai-pro   # bad
      ];

      extraConfig = ''
        syntax on
        set number
        set relativenumber

        let g:rainbow_active = 1

        "set expandtab  "spaces instead of tabs
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        "set colorcolumn=80
        filetype plugin indent on
        "set list lcs=tab:\·\

        set mouse=a
        set mousehide

        set splitright
        set splitbelow

        autocmd Filetype json
          \ let g:indentLine_setConceal = 0

        let g:paredit_electric_return=0
        let g:paredit_disable_ftindent=1

        "require'lspconfig'.nil_ls.setup{}

        inoremap <silent><expr> <Right> coc#pum#visible() ? coc#pum#confirm() : "\<Right>"

        colorscheme ayu-mirage
      '';

    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    zoxide = {
      enable = true;
    };

    zellij = {
      enable = true;
      enableFishIntegration = false; # opens by default
      settings = {
        #theme = "catppuccin-mocha";
      };
    };


    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "custom";
          custom_colors = {
            "1" = 1;
            "2" = 0;
          };
        };
        backend = "neofetch";
      };
    };


    kitty = {
      enable = true;
      settings = {
        font_family = "Fira Code";
        symbol_map = "U+F1900-U+F19FF sitelen-seli-kiwen-mono-kuniko";
        font_size = 10.0;

        enable_audio_bell = false;

        enabled_layouts = "horizontal,tall";

        #hide_window_decorations = "yes";
        window_border_width = 1.5;
        active_border_color = "#585b70";
        inactive_border_color = "#585b70";
        bell_border_color = "#585b70";
        #window_margin_width = "3";
        window_padding_width = 5;
        inactive_text_alpha = 0.6;

        tab_bar_min_tabs = 1;
        #tab_bar_margin_height = "0.0 10.0";
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        #tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };



  };



}
