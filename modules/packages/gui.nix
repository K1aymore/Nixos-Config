{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {
    environment.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };

    environment.systemPackages = with pkgs; [
      gtk3
      swt
      #eglinfo
      glxinfo
      clinfo
      vulkan-tools
      xorg.xdpyinfo
      kdePackages.kgpg
      glib

      libva-utils
      vdpauinfo

      alacritty
      kitty
      kdePackages.yakuake
      foot
      xfce.xfce4-terminal

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
      helvum
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
      pinentry
      pinentry-qt
      kdePackages.kdialog
      razergenie

      kdePackages.kate
      libreoffice
      kdePackages.okular
      kdePackages.gwenview
      digikam
      #clementine
      # qt-6 version doesn't save playlists well
      strawberry-qt6
      jamesdsp
      clematis
      
      #puddletag
      kid3
      tageditor
      picard
      vlc
      mpv
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
      plasma5Packages.kdeconnect-kde

      firefox-wayland
      #microsoft-edge
      #librewolf
      chromium
      discord
      #discord-canary
      vesktop
      element-desktop
      qbittorrent
      protonvpn-gui
      networkmanagerapplet
      #onionshare-gui
      #tor-browser-bundle-bin
      session-desktop
      zoom-us
      #lbry
      lagrange
      filezilla
      ff2mpv
      anki

      steam-run

      godot_4
      blender-hip
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
      zed-editor

      gsettings-desktop-schemas
      gsettings-qt
      v4l-utils
      libv4l


      obs-studio
      /* linuxKernel.packages.linux_5_16.v4l2loopback */


      # Games
      wineWowPackages.full
      lutris
      #playonlinux
      bottles
      #grapejuice
      protonup-qt
      #protontricks
      #openal
      heroic
      #legendary-gl
      winetricks
      protontricks

      
      parsec-bin
      r2modman

      #piper

      #minecraft
      #itch
      prismlauncher
      jdk17
      jdk11
      jdk8

    ];


    nixpkgs.overlays = [
      (final: prev: {
        # lapce = prev.lapce.overrideAttrs (o: {
        #   version = "nightly";

        #   src = pkgs.fetchFromGitHub {
        #     owner = "lapce";
        #     repo = "lapce";
        #     rev = "nightly";
        #     hash = "sha256-McwnYHaw0LYDeHLDQzfqRIYMV2FoiMdHyOL/EE8/esU=";
        #   };
        # });
        
      })
    ];

    services.flatpak.enable = true;

    # home-manager.users.klaymore.programs.emacs = {
    #   enable = true;
    #   package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
    #   extraConfig = ''
    #     (setq standard-indent 4)
    #   '';
    # };


    programs = {
      obs-studio.enable = true;
      partition-manager.enable = true;
      gamemode.enable = true;
      gamescope.enable = true;
    };


    hardware.steam-hardware.enable = true;

    home-manager.users.klaymore.programs.mangohud = {
      enable = true;
      enableSessionWide = false;
      settings = {
        fps_limit = [ 0 150 60 ]; # doesn't work with mangoapp
        show_fps_limit = true;

        arch = true;
        vulkan_driver = true;
        wine = true;
        gamemode = true;
        vkbasalt = true;
        resolution = true;

        cpu_temp = true;
        gpu_temp = true;
        #gpu_fan = true;
        gpu_core_clock = true;
        gpu_mem_clock = true;
        #gpu_voltage = true;

        ram = true;
        vram = true;
        io_read = true;
        io_write = true;
      };
    };



    home-manager.users.klaymore.programs = {
      # firefox.profiles.default = {
      #   # hide empty tab groups
      #   userChrome = "
      #     #tabbrowser-tabs tab-group:not(:has(.tabbrowser-tab:not([hidden]))) .tab-group-label-container {
      #       margin: 0 !important;
      #       max-height: 0 !important;
      #       max-width: 0 !important;
      #       padding: 0 !important;
      #       visibility: hidden !important;
      #     }";
      # };

      lapce = {
        enable = false;

        plugins = [ {
            author = "MrFoxPro";
            name = "lapce-nix";
            version = "0.0.1";
            hash = "sha256-n+j8p6sB/Bxdp0iY6Gty9Zkpv9Rg34HjKsT1gUuGDzQ=";
          } {
            author = "dzhou121";
            name = "lapce-rust";
            version = "0.3.2162";
            hash = "sha256-hFKEMJt8lio/kuuZTDEshZ6NBjpDM65VoS6hl1CTSZ0=";
          } {
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