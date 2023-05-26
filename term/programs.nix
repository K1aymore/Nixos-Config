{ pkgs, home-manager, nixvim, ... }:

{

  imports = [
    home-manager.nixosModule
    nixvim.nixosModules.nixvim
  ];

  home-manager.users.klaymore.programs = {
    home-manager.enable = true;


    git = {
      enable = true;
      userName = "K1aymore";
      userEmail = "klaymorer@protonmail.com";
      signing = {
        key = "BAE085A5C70F19F7";
        signByDefault = true;
      };
      ignores = [
        "*.swp"
        ".syncthing*"
      ];
      extraConfig = {
        init.defaultbranch = "main";

        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          navigate = true;    # use n and N to move between diff sections
          light = false ;     # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        };
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";

      };
    };

    helix = {
      enable = true;

      settings = {
        theme = "catppuccin_mocha";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;

          cursor-shape.insert = "bar";

          indent-guides.render = true;
        };
        keys.normal = {
          C-s = ":w";
        };
      };
    };


    neovim = {
      enable = false;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      # coc.enable = true;
      #nvim-treesitter.withAllGrammars
      # nerdtree ultisnips vimproc slimv tagbar vim-surround vim-airline haskell-vim vim-parinfer
      plugins = with pkgs.vimPlugins; [
        indentLine
        rainbow #YouCompleteMe
        #minimap-vim
        vim-fugitive #ale nvim-autopairs
        neoformat
        vim-nix
        rust-vim
        leap-nvim

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

        require'lspconfig'.nil_ls.setup{}

        colorscheme ayu-mirage
      '';

    };

    zoxide = {
      enable = true;
    };

  };



  programs.nixvim = {
    enable = true;

    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2; # Tab width should be 2
    };


    extraPlugins = with pkgs.vimPlugins; [
      indentLine
      leap-nvim

      neovim-ayu
    ];

    plugins = {
      treesitter = {
        enable = true;
        indent = true;
      };
      treesitter-rainbow.enable = true;
      fugitive.enable = true;

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };

      rust-tools.enable = true;
      lsp.servers.rust-analyzer.enable = true;
      lsp.servers.nil_ls.enable = true;
    };

    colorscheme = "neovim-ayu";

  };


}
