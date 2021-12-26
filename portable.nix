{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix


      # ./system/xp-pen.nix

      #./impermanence/system.nix
      #./impermanence/home.nix
    ];


  networking = {
    hostName = "portable";
    firewall.enable = true;
  };

}




