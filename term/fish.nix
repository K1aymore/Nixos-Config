{ config, pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in {

  users.users.klaymore.shell = pkgs.fish;

  home-manager.users.klaymore.programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      /* package.disabled = true; */
    };
  };


  home-manager.users.klaymore.programs.fish = {
    enable = true;
    shellAliases = config.environment.shellAliases;
  };

}
