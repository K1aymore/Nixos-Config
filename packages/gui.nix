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
    wl-color-picker

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
    zoom-us
    #lbry
    lagrange
    filezilla
    ff2mpv

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
    config = lib.mkMerge [ rec {
      fullscreen = true;
      # fs-screen = 0; # screen numbers change sometimes
      # screen = 0;
      # autofit = "100%";
      # window-maximized = true;
      keep-open = false;

      alang = "eng,en,enUS,en-US";
      #af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
      af = "loudnorm=I=-20";
      volume-max = 150;


      # best quality, except for 8K which is dumb
      ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";

      profile = "gpu-hq";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      deband = true;

      # Causes jitter and missed/delayed frames with display-resample
      hwdec = if video-sync == "audio" then "auto" else "no";

      # SSimSuperRes causes jitter with display-resample
      video-sync = "display-resample-vdrop";
      interpolation = true;
      tscale = "oversample";
    } (lib.mkIf systemSettings.hdr { # always output in HDR even for SDR videos
      vo = "gpu-next"; # dmabuf-wayland doesn't work with hdr
      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      target-trc = "pq"; # Output in HDR
      target-colorspace-hint = true; # makes no difference with target-trc=srgb
    })];
    profiles = {
      # Play SDR video nicely (maybe not "correctly" in HDR)
      SDR = lib.mkIf systemSettings.hdr {
        profile-cond = "video_params and p[\"video-params/primaries\"] ~= \"bt.2020\""; # only on SDR videos
        profile-restore = "copy";

        # Purple test She-Ra S5E6 4:39
        # Red test Arcane S1E7 7:54
        # Saturation test Arcane S1E7 21:37 <- everything except bt.2020 is oversaturated
        #
        # bt.709: way oversaturated
        # bt.470m: messed up purples
        # dci-p3: Pretty good balance
        # display-p3: like dci-p3 with less reds
        # film-c: Between bt.2020 and dci-p3. Looks pretty good
        # aces-ap1: A lot like bt.2020 except worse
        # bt.2020: correct but looks undersaturated compared to SDR colors at +40%
        # apple: more saturated than dci-p3, messed up purples
        # adobe: similar saturation to dci-p3 but greens are way too yellow
        # cie1931: like adobe but with messed up purples
        target-prim = "bt.2020";


        # caps at 203 nits unless doing inverse-tone-mapping
        # "auto" is affected by SDR brightness
        # anything above 203 is the same as auto with SDR Brightness at 203
        target-peak = 550;

        tone-mapping = "bt.2446a"; # Only affects inverse-tone-mapping, all other options bad
        inverse-tone-mapping = false; # Not good for 2D animation
      };
      Upscale = lib.mkIf (config.networking.hostName == "pc") {
        profile-cond = "width < 2560";
        profile-restore = "copy";

        scale = "ewa_lanczos4sharpest"; # No visible difference but what the hey
        #glsl-shaders = "${./-mpvShaders/CAS.glsl}";
      };
    };
    bindings = {
      "CTRL+`" = "set target-peak auto";
      "CTRL+1" = "set target-peak 550";
      "CTRL+2" = "cycle inverse-tone-mapping";

      "CTRL+4" = "cycle-values target-prim bt.2020 film-c bt.709";
      "CTRL+5" = "cycle-values target-trc pq srgb auto";
      "CTRL+6" = "cycle-values video-sync display-resample-vdrop audio";

      "CTRL+i" = "cycle interpolation";


      "CTRL+v" = "af toggle dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
      "CTRL+b" = "af toggle earwax";
      "CTRL+n" = "af toggle loudnorm=I=-20";

      "CTRL+8" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/CAS.glsl}\"; show-text \"CAS\"";
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
