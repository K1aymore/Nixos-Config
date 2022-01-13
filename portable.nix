{ config, pkgs, ... }:

{

  imports = [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix

      ./portable/syncthing.nix

      ./system/opentablet.nix
      #./home-manager/home-manager.nix

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];


  networking = {
    hostName = "portable";
    firewall.enable = true;
  };

}
