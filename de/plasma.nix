{ pkgs, lib, config, systemSettings, ... }:

{

  options = {
    myOptions.plasma.enable = lib.mkEnableOption "Plasma";
  };


  config = lib.mkIf config.myOptions.plasma.enable {

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "KDE";
    };

    services = {
      displayManager.sddm.enable = true;
      # displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
      desktopManager.plasma6.enable = true;
    };


    services.dbus.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kde-gtk-config
    ];


    services.blueman.enable = false; # Plasma comes with a Bluetooth daemon

  };
}
