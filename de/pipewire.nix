{ config, pkgs, ... }:

{

  sound.enable = false;
  hardware.pulseaudio.enable = false;


  # rtkit is optional but recommended
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;  # true anyways
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;

  };



}