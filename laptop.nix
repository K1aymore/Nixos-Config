{ config, pkgs, ... }:

{

  imports = [
      ./base.nix
      ./locale/colemak.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/games.nix

      ./system/opentablet.nix
      ./system/touchegg.nix

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];

  environment.variables = {
    XKB_DEFAULT_VARIANT = "colemak";
  };


  networking = {
    hostName = "laptop";
    #interfaces.wlp2s0.useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 22067 ];  # Syncthing transfers & relay
      allowedUDPPorts = [ 21027 22067 ];  # Syncthing discovery
    };
  };


  services.tlp.enable = true;


  services.syncthing.folders = {
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "server" "pc" "portable" "phone" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/nix/dotfiles";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/nix/cfg";
      devices = [ "server" "pc" "portable" "phone" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    "Ellida Sync" = {
      path = "/synced/Ellida Sync";
      devices = [ "server" "pc" "portable" "cDesk" ];
      ignorePerms = false;
    };
    "Ellida Projects" = {
      path = "/synced/Ellida Projects";
      devices = [ "server" "pc" "portable" "cDesk" ];
      ignorePerms = true;
    };
    "Websites" = {
      path = "/synced/Websites";
      devices = [ "server" "pc" "portable" "phone" ];
      ignorePerms = false;
      rescanInterval = 30;
    };
  };




}
