# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  # List packages installed in system profile. To search, run:
  # $ nix search wget

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {

  imports = [
    # import stuff here
  ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  

  environment.systemPackages = with pkgs; [
    dolphin
    filelight
    gparted
    ark

    kate
    atom
    vlc
    okular
    gwenview
    clementine
    krita

    keepassxc
    libreoffice

    google-chrome
    firefox
    element-desktop
    qbittorrent
    lmms

    lutris
    discord
    ungoogled-chromium

    eclipses.eclipse-java
    jetbrains.idea-community
    vscodium

    fabric-installer
    minecraft
    multimc

  ];


  programs = {
    partition-manager.enable = true;
    steam.enable = true;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

}









