{ config, pkgs, ... }:

{

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };

}
