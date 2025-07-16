{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.plasma.enable {
    klaymore.gui.enable = true;

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "KDE";
    };

    services = {
      displayManager.sddm.enable = true;
      # displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
      desktopManager.plasma6.enable = true;
    };


    xdg.portal.enable = true;
    services.dbus.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kde-gtk-config
    ];


    services.blueman.enable = false; # Plasma comes with a Bluetooth daemon

  };
}
