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
    libsForQt5.kio
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
    libsForQt5.kdialog

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

    libsForQt5.kalk
    libsForQt5.kcalc
    speedcrunch
    libsForQt5.akonadi-calendar
    plasma5Packages.kdeconnect-kde

    firefox-wayland
    #microsoft-edge
    #librewolf
    ungoogled-chromium # for Discord
    discord
    xwaylandvideobridge
    element-desktop
    qbittorrent
    #onionshare-gui
    #tor-browser-bundle-bin
    #session-desktop-appimage
    #zoom-us
    #lbry
    lagrange
    filezilla
    ff2mpv

    steam-run
    gamescope

    unstable.godot_4
    blender-hip
    #python39Packages.pyzmq
    libresprite
    pixelorama
    krita
    #opentoonz
    inkscape
    libsForQt5.kdenlive
    #movit
    #log4cxx
    lmms
    musescore
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
      strawberry = prev.strawberry.overrideAttrs (o: {
        version = "1.0.21";

        src = pkgs.fetchFromGitHub {
          owner = "jonaski";
          repo = "strawberry";
          rev = "1.0.21";
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
      hwdec = "auto-safe";
      
      fullscreen = true;
      fs-screen = 0;
      screen = 0;
      window-maximized = "yes";
      keep-open = "no";
      
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      deband = true;
      
      interpolation = false;
      video-sync = "display-resample-vdrop";
      tscale = "oversample";
    };
    mpv.bindings = {
      "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
      "CTRL+1" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode A (HQ)\"";
      "CTRL+2" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_Soft_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode B (HQ)\"";
      "CTRL+3" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode C (HQ)\"";
      "CTRL+4" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_M.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode A+A (HQ)\"";
      "CTRL+5" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_Soft_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_Soft_M.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode B+B (HQ)\"";
      "CTRL+6" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/Anime4K/Anime4K_Clamp_Highlights.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x2.glsl}:${./-mpvShaders/Anime4K/Anime4K_AutoDownscalePre_x4.glsl}:${./-mpvShaders/Anime4K/Anime4K_Restore_CNN_M.glsl}:${./-mpvShaders/Anime4K/Anime4K_Upscale_CNN_x2_M.glsl}\"; show-text \"Anime4K: Mode C+A (HQ)\"";
      "CTRL+7" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/CAS.glsl}\"; show-text \"CAS\"";
      "CTRL+8" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/FSR.glsl}\"; show-text \"FSR\"";
      "CTRL+9" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
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
