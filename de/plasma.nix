{ pkgs, lib, systemSettings, ... }:

{

  imports = [
    ./x11.nix
    ./wayland.nix
    ./pipewire.nix
  ] ++ lib.optionals systemSettings.hdr [
    ./hdr.nix
  ];

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


  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5 = {
    plasma6Support = true;
    waylandFrontend = true;
    addons = with pkgs; [
      fcitx5-mozc
    ];
  };


}
