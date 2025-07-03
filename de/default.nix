{ pkgs, lib, config, systemSettings, ... }:

{

  imports = [
    ./hyprland.nix
    ./plasma.nix
    ./niri.nix
  ] ++ lib.optionals systemSettings.hdr [
    ./hdr.nix
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";  # for VSCode Discord etc
  };


  environment.systemPackages = with pkgs; [
    wayland-utils
  	xwayland
  	kdePackages.xwaylandvideobridge
  ];


  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    # Configure keymap in X11
    xkb.layout = "us";
    # xkbOptions = "eurosign:e";
  };

  services.libinput = {
    enable = true;
    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };
    # touchpad settings
    touchpad = {
      # accelProfile = "flat";
      naturalScrolling = true;
      disableWhileTyping = false;
    };
  };


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      #xdg-desktop-portal
      #xdg-desktop-portal-kde
      #xdg-desktop-portal-wlr

      # for Firefox cursor, fixes Vesktop?
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "*";
    };
  };


  services.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;  # true anyways
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    wireplumber = {
      enable = true;
      # extraConfig = {
      #   "wireplumber.profiles" = {
      #     "main" = {
      #       "monitor.libcamera" = "disabled";
      #     };
      #   };
      # };
    };
  };
  
  # environment.etc."/pipewire/pipewire.conf.d/pipewire.conf".text = ''
  #   default.clock.quantum = 2048 #1024
  #   default.clock.min-quantum = 1024 #32
  #   default.clock.max-quantum = 4096 #2048 
  # '';

}
