{ config, pkgs, ... }:

  # List packages installed in system profile. To search, run:
  # $ nix search wget

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  /* unstable = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz); */
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
    /* unstable.itch */
    # unstable.polymc

    wesnoth
    opendune
    zeroad
    galaxis
    xlife
    openrct2
    eternity
  ];


  programs = {
    steam.enable = true;
  };


}
