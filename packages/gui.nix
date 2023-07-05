{ pkgs, config, ... }:

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
    #"electron-11.5.0"
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
    flameshot
    onboard
    xkbd
    #latte-dock
    remmina
    xfce.thunar
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
    picard
    vlc
    mpv
    #haruna
    #mpc-qt
    smplayer
    mediainfo-gui
    audacity
    tenacity
    sfxr
    sfxr-qt
    #handbrake
    k3b

    syncplay
    python39Packages.certifi
    python39Packages.twisted

    keepassxc

    libsForQt5.kalk
    libsForQt5.kcalc
    speedcrunch
    libsForQt5.akonadi-calendar
    plasma5Packages.kdeconnect-kde

    firefox-wayland
    #microsoft-edge
    librewolf
    ungoogled-chromium # for Discord
    discord
    element-desktop
    qbittorrent
    #onionshare-gui
    #tor-browser-bundle-bin
    #session-desktop-appimage
    #zoom-us
    #lbry

    unstable.godot_4
    stable.blender
    #python39Packages.pyzmq
    libresprite
    krita
    inkscape
    libsForQt5.kdenlive
    #movit
    #log4cxx
    lmms
    musescore
    #reaper
    ardour
    furnace
    josm
    love
    zola

    gsettings-desktop-schemas
    gsettings-qt
    v4l-utils
    libv4l

    xfce.xfce4-terminal


    obs-studio
    /* linuxKernel.packages.linux_5_16.v4l2loopback */


    nil # Nix LSP
    nixpkgs-fmt

  ];


  nixpkgs.overlays = [
    (final: prev: {
      vscodium = prev.vscodium.overrideAttrs (o: {
        postInstall = (o.postInstall or "") + ''
          cp -f ${./icons/vscodium-paulo22s.png} $out/share/pixmaps/code.png
        '';
      });
    })
  ];


  home-manager.users.klaymore.programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        redhat.java
        vscjava.vscode-java-debug
        matklad.rust-analyzer
        jnoortheen.nix-ide
        #ms-vscode.cpptools
        #ms-python.python
        #ms-python.vscode-pylance
        #ms-azuretools.vscode-docker
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "mayukaithemevsc";
          publisher = "GulajavaMinistudio";
          version = "3.2.3";
          sha256 = "a0f3c30a3d16e06c31766fbe2c746d80683b6211638b00b0753983a84fbb9dad";
        }
        {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.291.0";
          sha256 = "cabda0c4af2a58defa12c868b82be60109a82ed04efdca23d0829747d5fa0411";
        }
        {
          name = "nunjucks-template";
          publisher = "eseom";
          version = "0.5.1";
          sha256 = "CkHPyLZMtyLmqEzRMBqjxHV51R3AYrt8RJ5JQN1egWI=";
        }
      ];

      userSettings = {
        "workbench.colorTheme" = "Mayukai Semantic Mirage";
        "workbench.iconTheme" = "ayu";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
          };
        };

        "git.enableCommitSigning" = true;
      };
    };

    emacs = {
      enable = true;
      package = with pkgs; ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [ emacsPackages.slime ]));
      extraConfig = ''
        (setq standard-indent 4)
      '';
    };
  };

  services.emacs = {
    enable = true;
    package = config.home-manager.users.klaymore.programs.emacs.package;
  };


  programs = {
    partition-manager.enable = true;
  };

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

}
