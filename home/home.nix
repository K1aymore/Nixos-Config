{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz";
  dots = /nix/dotfiles;
in
{

  imports = [
    (import "${home-manager}/nixos")
  ];


  home-manager.users.klaymore = {
    home.homeDirectory = "/home/klaymore";

    programs = {
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
        # nerdtree ultisnips vimproc slimv
        plugins = with pkgs.vimPlugins; [ vim-airline tagbar indentLine YouCompleteMe vim-surround
          vim-nix haskell-vim vim-parinfer ];

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

    };



    home.file = {
      # export PATH=”$PATH:/synced/Sync/Linux/BashScripts”  # this breaks sudo
      ".bashrc".text = ''
        export GPG_TTY=$(tty)
      '';

      /* ".atom/atom-discord".source = "${dots}/Atom/.atom/atom-discord";
      ".atom/packages".source = "${dots}/Atom/.atom/packages";
      ".atom/config.cson".source = "${dots}/Atom/.atom/config.cson";
      ".atom/github.cson".source = "${dots}/Atom/.atom/github.cson"; */

      ".atom" = {
        source = "${dots}/Atom/.atom";
        recursive = true;
      };

      ".config" = {
        source = "${dots}/Plasma/.config";
        recursive = true;
      };
    };



    home.stateVersion = "21.11";
  };


}
