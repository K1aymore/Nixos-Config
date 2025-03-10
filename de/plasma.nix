{ pkgs, lib, config, systemSettings, ... }:

{

  options = {
    myOptions.plasma = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "run hyprland";
    };
  };


  config = lib.mkIf config.myOptions.plasma {

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
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      #xdg-desktop-portal
      #xdg-desktop-portal-kde
      #xdg-desktop-portal-wlr

      # for Firefox cursor, fixes Vesktop?
      xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kde-gtk-config
  ];


  services.blueman.enable = false; # Plasma comes with a Bluetooth daemon

};
}
