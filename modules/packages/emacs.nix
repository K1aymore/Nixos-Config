{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.emacs.enable {

    home-manager.users.klaymore.programs.doom-emacs = {
      enable = true;
      #emacs = pkgs.emacs-pgtk;
      doomDir = ./doom.d;
      doomLocalDir = "/home/klaymore/doomLocal";
      # extraPackages = epkgs: [
      #   pkgs.emacsPackages.catppuccin-theme
      #   epkgs.catppuccin-theme
      #   epkgs.treesit-grammars.with-all-grammars
      # ];
    };

  };
}