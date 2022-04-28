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
    gtk3
    swt

    dolphin
    filelight
    gparted
    ark
    libsForQt5.kio
    spectacle
    pavucontrol
    qjackctl
    carla
    gnome.gnome-bluetooth
    gnome.gnome-control-center
    mono
    libsForQt5.breeze-qt5
    libsForQt5.libksysguard

    kate
    atom
    libreoffice
    okular
    gwenview
    clementine
    strawberry
    puddletag
    kid3
    tageditor
    vlc
    mpv
    mediainfo-gui
    audacity
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
    /* librewolf */
#     firefox-devedition-bin
    element-desktop
    qbittorrent
    flood
    #onionshare-gui
    tor-browser-bundle-bin
    discord
    session-desktop-appimage
    zoom-us

    godot
    blender
    libresprite
    krita
    libsForQt5.kdenlive
    lmms

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l

    xfce.xfce4-terminal


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
