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
    firewall.enable = true;
  };





  networking.firewall = {
    allowedTCPPorts = [ 22000 22067 ];  # transfers & relay
    allowedUDPPorts = [ 21027 22067 ];  # discovery
  };

  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    relay.enable = true;
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
    };
    folders = {
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
        devices = [ "server" "pc" "laptop" ];
        ignorePerms = false;
      };
      "Ellida Projects" = {
        path = "/synced/Ellida Projects";
        devices = [ "server" "pc" "laptop" ];
        ignorePerms = true;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "server" "pc" "laptop" "phone" ];
        ignorePerms = false;
      };
    };
  };





}
