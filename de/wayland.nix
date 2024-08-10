{ pkgs, ... }:

{

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";  # for VSCode Discord etc
    XDG_CURRENT_DESKTOP = "KDE";
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal
      #xdg-desktop-portal-wlr

      # for Firefox cursor
      #xdg-desktop-portal-gtk
    ];
    # config.common = {
    #   default = [ "kde" ];
    #   "org.freedesktop.impl.portal.Lockdown" = [ "kde" ];
    # };
  };

  environment.systemPackages = with pkgs; [
    wayland-utils
  	xwayland
  	xwaylandvideobridge
    #slurp
    #wofi
  ];


}
