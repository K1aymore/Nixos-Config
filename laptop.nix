{ config, pkgs, ... }:

{

  imports = [
    ./base.nix
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    ./system/pipewire.nix
    ./de/sway.nix
    ./de/plasma.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix

    ./system/opentablet.nix
    ./system/touchegg.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];


  services.getty.autologinUser = "klaymore";

  networking = {
    hostName = "laptop";
    hostId = "e86a53d5";  # head -c 8 /etc/machine-id
    #interfaces.wlp2s0.useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 22067 ];  # Syncthing transfers & relay
      allowedUDPPorts = [ 21027 22067 ];  # Syncthing discovery
    };
  };

  #services.xserver.displayManager.startx.enable = true;

  services.tlp.enable = true;
  services.blueman.enable = true;


  services.syncthing.folders = {
    "Archive" = {
      path = "/synced/Archive";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/nix/dotfiles";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/nix/cfg";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    /* "Ellida Sync" = {
      path = "/synced/Ellida Sync";
      devices = [ "server" "pc" "portable" "cDesk" ];
      ignorePerms = false;
    }; */
    "Ellida Projects" = {
      path = "/synced/Ellida Projects";
      devices = [ "server" "pc" "portable" "cDesk" ];
      ignorePerms = true;
    };
    "Websites" = {
      path = "/synced/Websites";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" ];
      ignorePerms = false;
      rescanInterval = 30;
    };
  };




}
