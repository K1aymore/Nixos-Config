{ config, pkgs, ... }:

{

  imports = [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix
      ./de/sway.nix

      ./packages/gui.nix

      ./system/opentablet.nix
      #./home-manager/home-manager.nix

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];


  networking = {
    hostName = "portable";
    hostId = "a0d721b4";  # head -c 8 /etc/machine-id
  };



  services.syncthing.folders = {
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "server" "pc" "laptop" "phone" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/nix/dotfiles";
      devices = [ "server" "pc" "laptop" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/nix/cfg";
      devices = [ "server" "pc" "laptop" "phone" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "server" "pc" "laptop" ];
      ignorePerms = false;
    };
    "Archive" = {
      path = "/synced/Archive";
      devices = [ "server" "pc" ];
      ignorePerms = false;
    };
    "Ellida Sync" = {
      path = "/synced/Ellida Sync";
      devices = [ "server" "pc" "laptop" "cDesk" ];
      ignorePerms = false;
    };
    "Ellida Projects" = {
      path = "/synced/Ellida Projects";
      devices = [ "server" "pc" "laptop" "cDesk" ];
      ignorePerms = true;
    };
    "Websites" = {
      path = "/synced/Websites";
      devices = [ "server" "pc" "laptop" "phone" ];
      ignorePerms = false;
    };
  };




}
