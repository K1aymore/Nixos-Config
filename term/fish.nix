{ config, pkgs, ... }:

{

  users.users.klaymore.shell = pkgs.fish;

  home-manager.users.klaymore.programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      /* package.disabled = true; */
    };
  };


  home-manager.users.klaymore.programs.fish = {
    enable = true;
    shellAliases = {

    };
  };

}
