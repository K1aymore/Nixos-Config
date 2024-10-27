{ pkgs, config, nix-std, lib, systemSettings, ... }:

{

  # For discord wayland pipewire screensharing
  nixpkgs.config.ungoogled-chromium.commandLineArgs = "
    --ozone-platform=auto
    --disable-features=UseChromeOSDirectVideoDecoder
    --enable-features=RunVideoCaptureServiceInBrowserProcess
    --disable-gpu-memory-buffer-compositor-resources
    --disable-gpu-memory-buffer-video-frames
    --enable-hardware-overlays
  ";

  nixpkgs.config.permittedInsecurePackages = [
    # "libtiff-4.0.3-opentoonz"
    # "libxls-1.6.2"
  ];

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
    glib

    libva-utils
    vdpauinfo

    wl-clipboard
    swaylock
    swayidle
    wob
    #mako # notification daemon, annoying on plasma
    alacritty
    kitty
    dmenu
    #wofi
    xdg-utils
    grim

    dolphin
    filelight
    gparted
    ark
    kdePackages.kio
    spectacle
    #flameshot
    #onboard
    #xkbd
    #latte-dock
    remmina
    #xfce.thunar
    akregator

    pavucontrol
    qjackctl
    #helvum
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

    kate
    libreoffice
    okular
    gwenview
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

    stable.syncplay
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
    #ungoogled-chromium
    discord
    vesktop
    xwaylandvideobridge
    element-desktop
    qbittorrent
    protonvpn-gui
    networkmanagerapplet
    #onionshare-gui
    #tor-browser-bundle-bin
    #session-desktop-appimage
    #zoom-us
    #lbry
    lagrange
    filezilla
    ff2mpv

    steam-run

    godot_4
    blender-hip
    #python39Packages.pyzmq
    libresprite
    aseprite
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
    logisim-evolution

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l

    xfce.xfce4-terminal


    obs-studio
    /* linuxKernel.packages.linux_5_16.v4l2loopback */


    lapce
    #nil # Nix LSP
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

  /*home-manager.users.klaymore.home.file = {
    ".config/lapce-nightly/settings.toml".text = nix-std.lib.serde.toTOML {
      core = {
        color-theme = "Lapce Dark";
        icon-theme = "Material Icons";
      };
      editor = {
        font-size = 14;
        font-family = "Fira Code";
        line-height = 1.5;
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
      
      lapce-nix.lsp-path = "/run/current-system/sw/bin/nil";
      lapce-rust.serverPath = "/run/current-system/sw/bin/rust-analyzer";
      lapce-cpp-clangd."volt.serverPath" = "/run/current-system/sw/bin/clangd";
      
    };
  };*/


  # home-manager.users.klaymore.programs.emacs = {
  #   enable = true;
  #   package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
  #   extraConfig = ''
  #     (setq standard-indent 4)
  #   '';
  # };


  home-manager.users.klaymore.programs.mpv = {
    enable = true;
    config = {
      fullscreen = true;
      fs-screen = 0;
      screen = 0;
      autofit = "100%";
      window-maximized = "yes";
      keep-open = "no";

      alang = "eng,en,enUS,en-US";
      #af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";


      profile = "gpu-hq";
      hwdec = "vaapi,vulkan,auto";

      # best quality, except for 8K which is dumb
      ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      deband = true;

      video-sync = "display-resample-vdrop";
      interpolation = true;
      tscale = "oversample";
    } // lib.mkIf systemSettings.hdr {
      vo = "gpu-next"; # dmabuf-wayland doesn't work with hdr
      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      target-trc = "pq";
      target-prim = "bt.2020";
      target-colorspace-hint = true;
    };
    profiles = {
      # converts SDR into HDR
      SDR_HDR_EFFECT = lib.mkIf systemSettings.hdr {
        profile-cond = "video_params and p[\"video-params/primaries\"] ~= \"bt.2020\""; # only on SDR videos
        profile-restore = "copy";

        tone-mapping = "bt.2446a";
        target-peak = 550;
        inverse-tone-mapping = false;
      };
    };  
    bindings = {
      "CTRL+`" = "set target-peak auto";
      "CTRL+1" = "set target-peak 550";
      "CTRL+2" = "set target-peak 100";
      "CTRL+3" = "cycle inverse-tone-mapping";

      "CTRL+v" = "af toggle dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
      "CTRL+b" = "af toggle earwax";

      "CTRL+7" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/CAS.glsl}\"; show-text \"CAS\"";
      "CTRL+8" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/FSR.glsl}\"; show-text \"FSR\"";
      "CTRL+9" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
      "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";

      "CTRL+WHEEL_UP" = "add target-peak 25";
      "CTRL+WHEEL_DOWN" = "add target-peak -25";

      "a" = "vf toggle hflip";
      "b" = "cycle deband";

      "HOME" = "seek 0 absolute";
    };
    scripts = [
      #pkgs.mpvScripts.autocrop
    ];
  };

  # Used to be for copying shaders to config path, now instead use /nix/store path
  # home-manager.users.klaymore.home.file.".config/mpv" = {
  #   enable = true;
  #   recursive = true;
  #   source = ./-mpvShaders;
  # };

  home-manager.users.klaymore.home.file.".config/Clematis/config.json".text = builtins.toJSON {
    presence = {
      details = "{title}";
      state = "{artist}";
    };
  };



  services.emacs = {
    enable = false;
    package = config.home-manager.users.klaymore.programs.emacs.package;
  };


  programs = {
    partition-manager.enable = true;
  };


  services.flatpak.enable = true;
  xdg.portal.enable = true;


  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

}
