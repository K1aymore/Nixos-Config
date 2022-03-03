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
    libreoffice
    okular
    gwenview
    clementine
    /* strawberry */
    vlc
    mpv
    mediainfo-gui
    /* audacity */
    tenacity

    syncplay
    python39Packages.certifi
    python39Packages.twisted

    keepassxc

    libsForQt5.kalk
    libsForQt5.kcalc
    speedcrunch
    libsForQt5.akonadi-calendar

    google-chrome
    ungoogled-chromium
    firefox
#     firefox-devedition-bin
    element-desktop
    qbittorrent
    discord
    session-desktop-appimage
    zoom-us

    godot
    blender
    libresprite
    krita
    lmms

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l

    exodus

    nottetris2
    /* obs-studio */
    /* linuxKernel.packages.linux_5_16.v4l2loopback */

  ];


  programs = {
    partition-manager.enable = true;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

}
