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
      userName  = "K1aymore";
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
      };
    };


    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      # coc.enable = true;
      #nvim-treesitter.withAllGrammars
      # nerdtree ultisnips vimproc slimv tagbar vim-surround vim-airline haskell-vim vim-parinfer
      plugins = with pkgs.vimPlugins; [
        indentLine rainbow #YouCompleteMe
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
    enable = false;

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2;        # Tab width should be 2
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

      rust-tools.enable = true;
      lsp.servers.rust-analyzer.enable = true;
      lsp.servers.nil_ls.enable = true;
    };

    colorscheme = "neovim-ayu";

  };


}
