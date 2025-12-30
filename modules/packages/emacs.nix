{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.emacs.enable {

    environment.shellAliases = {
      doom = "~/.config/emacs/bin/doom";
    };

    services.emacs = {
      enable = true;
      package = pkgs.emacs; 
    };

    environment.systemPackages = with pkgs; [
      # required dependencies
      git
      emacs    # Emacs 27.2
      ripgrep
      # optional dependencies
      coreutils # basic GNU utilities
      fd
      clang

      pandoc
      shellcheck
      bash-language-server
      bashdb
      shfmt
    ];

    # home-manager.users.klaymore.programs.doom-emacs = {
    #   enable = true;
    #   #emacs = pkgs.emacs-pgtk;
    #   doomDir = ./doom.d;
    #   doomLocalDir = "/home/klaymore/doomLocal";
    #   # extraPackages = epkgs: [
    #   #   pkgs.emacsPackages.catppuccin-theme
    #   #   epkgs.catppuccin-theme
    #   #   epkgs.treesit-grammars.with-all-grammars
    #   # ];
    # };

  };
}
