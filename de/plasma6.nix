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
    displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
    desktopManager.plasma6.enable = lib.mkDefault true;
  };


  programs.dconf.enable = true;

}
