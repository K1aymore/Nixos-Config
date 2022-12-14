{ config, pkgs, ... }:

{

  imports = [
    ./x11.nix
    ./wayland.nix
  ];

  services.xserver = {
      displayManager.sddm.enable = true;
      displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
      desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sweet
  ];

}
