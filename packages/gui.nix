{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

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
    onboard
    xkbd

    #jamesdsp
    carla
    gnome.gnome-bluetooth
    gnome.gnome-control-center
    mono
    libsForQt5.breeze-qt5
    libsForQt5.kleopatra
    pinentry
    pinentry-qt

    kate
    atom
    libreoffice
    okular
    gwenview
    digikam
    clementine
    strawberry
    puddletag
    kid3
    tageditor
    vlc
    mpv
    #haruna
    #mpc-qt
    smplayer
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
    #flood
    #onionshare-gui
    tor-browser-bundle-bin
    discord
    #session-desktop-appimage
    zoom-us
    lbry

    godot
    blender
    libresprite
    krita
    inkscape
    libsForQt5.kdenlive
    davinci-resolve
    log4cxx
    lmms
    reaper

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l

    xfce.xfce4-terminal


    obs-studio
    /* linuxKernel.packages.linux_5_16.v4l2loopback */

  ];


  programs = {
    partition-manager.enable = true;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

}
