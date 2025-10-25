{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.wayland {
    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";  # for VSCode Discord etc
    };

    environment.systemPackages = with pkgs; [
      wayland-utils
      xwayland
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        #xdg-desktop-portal
        #xdg-desktop-portal-kde
        #xdg-desktop-portal-wlr

        # for Firefox cursor, fixes Vesktop?
        xdg-desktop-portal-gtk
      ];
      config = {
        common.default = "*";
      };
    };

  };
}