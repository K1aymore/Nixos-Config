{ config, pkgs, ... }:

{

  users.users.klaymore.shell = pkgs.elvish;

  programs.starship = {
    enable = true;
    settings = {
      /* package.disabled = true; */
    };
  };


  home-manager.users.klaymore.home.file.".config/elvish/rc.elv".text = ''
    fn nrs { sudo nixos-rebuild switch }
    fn nrb { sudo nixos-rebuild boot }
    fn nrbu { sudo nixos-rebuild boot --upgrade }

    fn conf { cd /nix/cfg }

    fn yd { /synced/Sync/Linux/BashScripts/yd }

    eval (zoxide init elvish | slurp)
    eval (starship init elvish)
  '';

}
