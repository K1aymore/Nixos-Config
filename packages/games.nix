{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    lutris
    playonlinux
    #grapejuice
    #protonup
    #protontricks
    #openal
    heroic
    legendary-gl

    #minecraft
    #itch
    prismlauncher
    jdk17
    jdk8

    wesnoth
    openttd
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

    parsec-bin
  ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # sudo flatpak install flathub com.valvesoftware.Steam
  # flatpak run com.valvesoftware.Steam

  hardware.steam-hardware.enable = true;

  #flatpak install flathub net.brinkervii.grapejuice
  #flatpak run net.brinkervii.grapejuice

  programs.gamemode = {
    enable = true;
  };

  /* programs = {
    steam.enable = true;
  }; */


}
