{ pkgs, config, nix-std, ... }:

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
    "libtiff-4.0.3-opentoonz"
    "libxls-1.6.2"
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
    dmenu
    wofi
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
    #remmina
    #xfce.thunar
    akregator

    pavucontrol
    qjackctl
    helvum
    easyeffects
    alsa-oss
    alsa-lib
    alsa-utils
    alsa-plugins
    hushboard
    kdePackages.xdg-desktop-portal-kde

    #jamesdsp
    carla
    gnome.gnome-bluetooth
    gnome.gnome-control-center
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
    clementine
    strawberry
    jamesdsp
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
    k3b

    stable.syncplay
    #python39Packages.certifi
    #python39Packages.twisted
    localsend

    keepassxc

    kdePackages.kalk
    kdePackages.kcalc
    speedcrunch
    kdePackages.akonadi-calendar
    plasma5Packages.kdeconnect-kde

    firefox-wayland
    #microsoft-edge
    #librewolf
    ungoogled-chromium # for Discord
    discord
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

    unstable.godot_4
    blender-hip
    #python39Packages.pyzmq
    #libresprite
    pixelorama
    krita
    #opentoonz
    inkscape
    kdePackages.kdenlive
    #movit
    #log4cxx
    lmms
    #reaper
    ardour
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
    nil # Nix LSP
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


  home-manager.users.klaymore.programs = {

    emacs = {
      enable = true;
      package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
      extraConfig = ''
        (setq standard-indent 4)
      '';
    };
    

    mpv.enable = true;
    mpv.config = {
      fullscreen = true;
      fs-screen = 0;
      screen = 0;
      window-maximized = "yes";
      keep-open = "no";
      alang = "eng,en,enUS,en-US";


      profile = "gpu-hq";
      hwdec = "auto-safe";

      ytdl-format = "bv*[height<=2160]+ba/b[height<=2160]";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      deband = true;
      
      interpolation = false;
      video-sync = "display-resample-vdrop";
      tscale = "oversample";
    };
    
    mpv.bindings = {
      "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
      "CTRL+1" = "apply-profile \"SDR_HDR_EFFECT\"";
      "CTRL+7" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/CAS.glsl}\"; show-text \"CAS\"";
      "CTRL+8" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/FSR.glsl}\"; show-text \"FSR\"";
      "CTRL+9" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
      "CTRL+WHEEL_UP" = "add target-peak 25";
      "CTRL+WHEEL_DOWN" = "add target-peak -25";
    };
    
  };
  
  home-manager.users.klaymore.home.file.".config/mpv" = {
    enable = false;
    recursive = true;
    source = ./-mpvShaders;
  };

  
  
  
  
  services.emacs = {
    enable = true;
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
