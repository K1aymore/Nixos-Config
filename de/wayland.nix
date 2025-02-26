{ pkgs, ... }:

{

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";  # for VSCode Discord etc
    XDG_CURRENT_DESKTOP = "KDE";
  };


  environment.systemPackages = with pkgs; [
    wayland-utils
  	xwayland
  	kdePackages.xwaylandvideobridge
    #slurp
    #wofi
  ];

}
