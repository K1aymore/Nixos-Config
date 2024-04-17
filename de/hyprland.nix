{config, pkgs, ...}:

{
  imports = [
  	./wayland.nix
  	./x11.nix
  ];

  programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
