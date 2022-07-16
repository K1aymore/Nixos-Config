{ config, pkgs, ... }:

{

  imports = [
    ./wayland.nix
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
  };

  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
    wob
    #mako # notification daemon # annoying on plasma
    alacritty # Alacritty is the default terminal in the config
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    wofi
  ];


}
