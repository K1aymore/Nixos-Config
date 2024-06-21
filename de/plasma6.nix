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


  programs.dconf.enable = true;



  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # kdePackages.xdg-desktop-portal-kde
    ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kde-gtk-config
  ];


}
