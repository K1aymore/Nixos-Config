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

  nixpkgs.config.ungoogled-chromium.commandLineArgs = "
    --ozone-platform=auto
    --disable-features=UseChromeOSDirectVideoDecoder
    --enable-features=RunVideoCaptureServiceInBrowserProcess
    --disable-gpu-memory-buffer-compositor-resources
    --disable-gpu-memory-buffer-video-frames
    --enable-hardware-overlays
  ";

  environment.systemPackages = with pkgs; [
    gtk3
    swt
    xwayland
    #eglinfo
    glxinfo
    clinfo
    vulkan-tools
    xorg.xdpyinfo
    kgpg

    wl-clipboard
    swaylock
    swayidle
    wob
    #mako # notification daemon, annoying on plasma
    alacritty # Alacritty is the default terminal in Sway config
    dmenu # Dmenu is the default in Sway config but i recommend wofi since its wayland native
    wofi

    dolphin
    filelight
    gparted
    ark
    libsForQt5.kio
    spectacle
    flameshot
    onboard
    xkbd
    #latte-dock
    remmina

    pavucontrol
    qjackctl
    helvum
    easyeffects
    alsa-oss
    alsa-lib
    alsa-utils
    alsa-plugins
    hushboard
    libsForQt5.xdg-desktop-portal-kde

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
    #puddletag
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
    plasma5Packages.kdeconnect-kde

    google-chrome
    chromium
    firefox-wayland
    /* librewolf */
#     firefox-devedition-bin
    discord
    element-desktop
    qbittorrent
    #transmission-qt
    #deluge
    #flood
    #onionshare-gui
    #tor-browser-bundle-bin
    #session-desktop-appimage
    #zoom-us
    #lbry
    #libsForQt5.kmail
    #thunderbird

    godot
    blender-hip
    python39Packages.pyzmq
    libresprite
    krita
    inkscape
    libsForQt5.kdenlive
    movit
    log4cxx
    lmms
    reaper
    ardour
    milkytracker
    hivelytracker
    josm

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
