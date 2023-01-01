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
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      # coc.enable = true;
      # nerdtree ultisnips vimproc slimv vim-surround vim-airline haskell-vim vim-parinfer elvish-vim
      plugins = with pkgs.vimPlugins; [ tagbar indentLine YouCompleteMe
        vim-nix ];

      extraConfig = ''
        syntax on
        set number
        set relativenumber

        set expandtab
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2

        set splitright
        set splitbelow

        autocmd Filetype json
          \ let g:indentLine_setConceal = 0

        let g:paredit_electric_return=0
        let g:paredit_disable_ftindent=1
      '';
    };

    zoxide = {
      enable = true;
    };

  };

}
