{ config, pkgs, ... }:

{

  sound.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

}
