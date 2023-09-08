{ pkgs, home-manager, ... }:

{

  imports = [
    home-manager.nixosModule
  ];

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    lutris
    playonlinux
    bottles
    #grapejuice
    #protonup
    #protontricks
    #openal
    heroic
    legendary-gl

    mangohud
    gamescope

    #minecraft
    #itch
    prismlauncher
    jdk17
    jdk8

    #wesnoth
    #openttd
    #simutrans
    #openrct2
    #zeroad
    #opendungeons
    #crawl
    #opendune
    #galaxis
    #xlife
    #eternity
    #freedroidrpg
    #osu-lazer
    #arx-libertatis

    pkgs-parsec.parsec-bin
  ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # sudo flatpak install flathub com.valvesoftware.Steam
  # flatpak run com.valvesoftware.Steam
  # sudo flatpak override --env=MANGOHUD=1 com.valvesoftware.Steam


  hardware.steam-hardware.enable = true;

  #flatpak install flathub net.brinkervii.grapejuice
  #flatpak run net.brinkervii.grapejuice

  programs.gamemode = {
    enable = true;
  };

  programs.gamescope.enable = true;

  home-manager.users.klaymore.programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      #fps_limit = 117;
      gamemode = true;
      vulkan_driver = true;
      wine = true;
    };
  };

  # environment.sessionVariables = {
  #   MANGOHUD = "1";
  # };

  /*programs = {
    steam.enable = true;
  };*/


}
