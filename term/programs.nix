{ config, pkgs, lib, ... }:

{

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
        YouCompleteMe indentLine rainbow
	      vim-fugitive ale nvim-autopairs
	      vim-nix
      ];

      extraConfig = ''
        syntax on
        set number
        set relativenumber
        
        let g:deoplete#enable_at_startup = 1

        "set expandtab  "spaces instead of tabs
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set colorcolumn=80
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

      '';

      extraPackages = with pkgs; [
        jdt-language-server
      ];
    };

    zoxide = {
      enable = true;
    };

  };

}
