{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    #lutris
    playonlinux
    #grapejuice
    protonup
    protontricks
    openal
    heroic
    legendary-gl

    minecraft
    #itch
    #multimc
    #polymc
    prismlauncher

    wesnoth
    openttd
    #simutrans
    #openrct2
    #zeroad
    opendungeons
    #crawl
    opendune
    galaxis
    xlife
    eternity
    freedroidrpg
    #osu-lazer
    arx-libertatis
  ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # sudo flatpak install flathub com.valvesoftware.Steam
  # flatpak run com.valvesoftware.Steam

  #flatpak install flathub net.brinkervii.grapejuice
  #flatpak run net.brinkervii.grapejuice


  /* programs = {
    steam.enable = true;
  }; */


}
