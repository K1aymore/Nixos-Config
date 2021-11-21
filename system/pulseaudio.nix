# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  users.extraUsers.klaymore.extraGroups = [ "audio" ];

}




