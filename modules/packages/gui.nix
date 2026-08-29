{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {
    environment.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };

    environment.systemPackages = with pkgs; [
      gtk3
      # swt
      #eglinfo
      mesa-demos
      clinfo
      vulkan-tools
      xdpyinfo
      kdePackages.kgpg
      glib

      libva-utils
      vdpauinfo

      alacritty
      kitty
      kdePackages.yakuake
      foot
      xfce4-terminal

      wl-clipboard
      swaylock
      swayidle
      wob
      #mako # notification daemon, annoying on plasma
      dmenu
      #wofi
      xdg-utils
      grim
      wl-color-picker

      kdePackages.dolphin
      kdePackages.filelight
      gparted
      kdePackages.ark
      kdePackages.kio
      kdePackages.spectacle
      #flameshot
      webcamoid
      cheese
      #onboard
      #xkbd
      #latte-dock
      remmina
      #xfce.thunar
      #akregator

      pavucontrol
      qjackctl
      crosspipe
      easyeffects
      alsa-oss
      alsa-lib
      alsa-utils
      alsa-plugins
      hushboard

      #jamesdsp
      #carla
      gnome-bluetooth
      gnome-control-center
      mono
      kdePackages.breeze
      kdePackages.kleopatra
      pinentry-curses
      kdePackages.kdialog

      kdePackages.kate
      libreoffice
      kdePackages.okular
      kdePackages.gwenview
      digikam
      #clementine
      strawberry
      jamesdsp
      clematis
      # calibre
      yacreader

      #puddletag
      kid3
      tageditor
      picard
      vlc
      makemkv
      #haruna
      #mpc-qt
      #smplayer
      mediainfo-gui
      audacity
      #tenacity
      sfxr
      sfxr-qt
      #handbrake
      #k3b
      superstable.displaycal
      eyedropper

      syncplay
      #python39Packages.certifi
      #python39Packages.twisted
      localsend
      wireshark

      keepassxc

      kdePackages.kalk
      kdePackages.kcalc
      speedcrunch
      kdePackages.akonadi-calendar
      kdePackages.kdeconnect-kde

      # firefox # in firefox.nix
      #microsoft-edge
      #librewolf
      chromium
      discord
      #discord-canary
      vesktop
      element-desktop
      signal-desktop
      mumble

      qbittorrent
      proton-vpn
      networkmanagerapplet
      #onionshare-gui
      #tor-browser-bundle-bin
      #session-desktop
      zoom-us
      #lbry
      lagrange
      filezilla

      steam-run
      river

      godot
      #unityhub
      pkgsRocm.blender
      #python39Packages.pyzmq
      libresprite
      #aseprite
      pixelorama
      krita
      #opentoonz
      inkscape
      kdePackages.kdenlive
      movit
      #log4cxx
      #lmms
      #reaper
      #ardour
      #furnace
      josm
      #love
      zola
      logisim
      logisim-evolution

      vscode-fhs
      # zed-editor

      gsettings-desktop-schemas
      gsettings-qt
      v4l-utils
      libv4l


      parsec-bin
      obs-studio
      /* linuxKernel.packages.linux_5_16.v4l2loopback */

    ];


    # nixpkgs.overlays = [
    #   (final: prev: {
    #     godot = prev.godot.overrideAttrs (o: {
    #       version = "4.5";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "ArchercatNEO";
    #         repo = "godot";
    #         rev = "wayland-hdr";
    #         hash = "sha256-4iLKa5digWZ36akw1GtEVDhZBRxgZ/hMEIpmWVX/Ktw=";
    #       };
    #     });

    #   })
    # ];

    services.flatpak.enable = true;



    programs = {
      obs-studio.enable = true;
      partition-manager.enable = true;
    };


    home-manager.users.klaymore.programs = {

      obs-studio.enable = true;
      element-desktop.enable = true;
      chromium.enable = true;

      anki = {
        enable = true;
        addons = with pkgs.ankiAddons; [
          adjust-sound-volume
          anki-connect
          passfail2
          review-heatmap
        ];
      };


      lapce = {
        enable = false;

        plugins = [
          {
            author = "MrFoxPro";
            name = "lapce-nix";
            version = "0.0.1";
            hash = "sha256-n+j8p6sB/Bxdp0iY6Gty9Zkpv9Rg34HjKsT1gUuGDzQ=";
          }
          {
            author = "dzhou121";
            name = "lapce-rust";
            version = "0.3.2162";
            hash = "sha256-hFKEMJt8lio/kuuZTDEshZ6NBjpDM65VoS6hl1CTSZ0=";
          }
          {
            author = "WalterOfNone";
            name = "ayu";
            version = "0.1.2";
            hash = "sha256-8m9joh8VTkd4fzNevFmZROsQ5Cl7si84oVQ01nTCjdo=";
          }
        ];

        settings = {
          core = {
            color-theme = "Ayu Mirage";
            modal = false;
            #icon-theme = "Material Icons";
          };
          editor = {
            font-size = 15;
            font-family = "Fira Code";
            line-height = 1.3;
            autosave-interval = 100;
            format-on-autosave = false;
            hover-delay = 150;
            show-tab = true;
            highlight-scope-lines = false;
            atomic-soft-tabs = true;
          };
          ui = {
            font-size = 14;
            font-family = "";
          };

          lapce-nix.lsp-path = "/run/current-system/sw/bin/nixd";
          lapce-rust.serverPath = "/run/current-system/sw/bin/rust-analyzer";
          lapce-cpp-clangd."volt.serverPath" = "/run/current-system/sw/bin/clangd";
        };
      };

    };

  };
}
