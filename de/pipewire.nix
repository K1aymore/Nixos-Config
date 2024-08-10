{ config, pkgs, ... }:

{

  hardware.pulseaudio.enable = false;


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
