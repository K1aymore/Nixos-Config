{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {

    services.emacs = {
      enable = true;
      package = pkgs.emacs; 
    };


    home-manager.users.klaymore.programs.emacs = {
      enable = true;
      # replace with pkgs.emacs-gtk if desired
      package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
      extraConfig = ''
        (setq standard-indent 2)
        (add-to-list 'default-frame-alist '(font . "Fira Code-10"))
        (set-fontset-font "fontset-default" '(#xF1900 . #xF19FF) "nasin-nanpa-10")
      '';
    };


  };
}