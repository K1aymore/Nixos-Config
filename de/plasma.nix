{ pkgs, lib, ... }:

{

  imports = [
    ./x11.nix
    ./wayland.nix
    ./pipewire.nix
  ];

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
    xserver.desktopManager.plasma5.enable = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.yakuake
  ];

  programs.dconf.enable = true;

}
