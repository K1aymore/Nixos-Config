{ pkgs, ... }:

{
  imports = [
    ./x11.nix
    ./wayland.nix
    ./pipewire.nix
  ];
  
  
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };
  
}