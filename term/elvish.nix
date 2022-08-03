{ config, pkgs, ... }:

{

  users.users.klaymore.shell = pkgs.elvish;

  programs.starship = {
    enable = true;
    /* settings = {

    }; */
  };


  home-manager.users.klaymore.home.file.".config/elvish/rc.elv".text = ''
    fn nrs { sudo nixos-rebuild switch }

    eval (starship init elvish)
  '';

}
