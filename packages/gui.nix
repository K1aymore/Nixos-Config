{ pkgs, ... }:

{

  imports = [
    ./mpv.nix
  ];
  
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
    carla
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
    lmms
    #reaper
    #ardour
    #furnace
    josm
    #love
    zola
    logisim
    logisim-evolution

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l


    obs-studio
    /* linuxKernel.packages.linux_5_16.v4l2loopback */


    #lapce
    nil # Nix LSP
    nixd
    nixpkgs-fmt

  ];


  /*nixpkgs.overlays = [
    (final: prev: {
      lapce = prev.lapce.overrideAttrs (o: {
        version = "nightly";

        src = pkgs.fetchFromGitHub {
          owner = "lapce";
          repo = "lapce";
          rev = "nightly";
          hash = "sha256-McwnYHaw0LYDeHLDQzfqRIYMV2FoiMdHyOL/EE8/esU=";
        };
      });
      
    })
  ];*/


  # home-manager.users.klaymore.programs.emacs = {
  #   enable = true;
  #   package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
  #   extraConfig = ''
  #     (setq standard-indent 4)
  #   '';
  # };


  home-manager.users.klaymore.home.file.".config/Clematis/config.json".text = builtins.toJSON {
    presence = {
      details = "{title}";
      state = "{artist}";
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


    # kitty: bugs with zellij + neovim after expanding window
    # konsole: slow with nvim in zellij
    # work fine: alacritty, foot, st

    # ctrl move and backspace by word: Alacritty, Kitty
    # ctrl backspace only one letter: konsole, st, foot

    # Alacritty re-renders during resizing, kinda jerky
    # Foot only rerenders during pause while resizing
    # st re-renders while resizing
    # st is only for X11
    # Alacritty feels slightly higher frame rate than foot

    # glitch when resizing cmatrix: konsole, alacritty, kitty, foot. st?
    # konsole fonts kinda blurry
    # kitty fonts crisp
    # fonts crunchy on 90% scale: alacritty, foot

    # ligature support: kitty
    # no ligs: alacritty, konsole, foot

    # MPV tct squished on alacritty, foot, slightly kitty.
    # mpv tct good on Konsole
    # line height issue? squished (horizontally) terminals have bigger line height
    # Konsole: screen tearing and stuttering
    # Kitty: bad stuttering
    # Alacritty: slight stuttering but better
    # foot: stuttering

    # bidirectional support: konsole, kitty
    # no bidir: alacritty, foot, st


    kitty = {
      enable = true;
      settings = {
        font_family = "Fira Code";
        symbol_map = "U+F1900-U+F19FF Fairfax Hax HD";
        narrow_symbols = "U+F1900-U+F19FF 1";
        font_size = 10.0; # breaks bottoms of "g"s if less than 10?
        "modify_font cell_height" = "100%";

        show_hyperlink_targets = "yes";
        underline_hyperlinks = "always";

        enable_audio_bell = false;

        enabled_layouts = "tall,horizontal";

        #hide_window_decorations = "yes";
        window_border_width = 1;
        active_border_color = "#585b70";
        inactive_border_color = "#585b70";
        bell_border_color = "#585b70";
        #window_margin_width = "3";
        window_padding_width = 4;
        inactive_text_alpha = 0.8;

        tab_bar_min_tabs = 1;
        #tab_bar_margin_height = "0.0 10.0";
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        #tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = { family = "Fira Code"; style = "Regular"; };
          size = 10;
          offset.y = 0;
        };
      };
    };

    foot = {
      enable = true;
      settings = {
        main = {
          font = "Fira Code:size=10";
        };
        mouse = {
          #hide-when-typing = "yes";
        };
      };
    };


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

  programs = {
    partition-manager.enable = true;
  };


  services.flatpak.enable = true;
  xdg.portal.enable = true;


}
