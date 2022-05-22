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
    wine
    lutris
    # playonlinux
    grapejuice
    protonup
    protontricks
    openal

    minecraft
    multimc
    unstable.itch
    unstable.polymc

    wesnoth
    zeroad
    opendungeons
    crawl
    opendune
    galaxis
    xlife
    openrct2
    eternity
    osu-lazer
  ];


  programs = {
    steam.enable = true;
  };


}
