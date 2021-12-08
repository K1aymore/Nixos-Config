{ config, pkgs, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];  # transfers
    allowedUDPPorts = [ 21027 ];  # discovery
  };

  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "laptop" = { id = "34AVXMA-IPYWWB6-42RQTSB-KKWKSN5-MYUB4II-AJBV5WI-OWG65XZ-FDZKMA3"; };
      "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
    };
    folders = {
      "Sync" = {
        path = "/synced/Sync";
        devices = [ "pc" "laptop" "phone" ];
        ignorePerms = false;
      };
      "NixCfg" = {
        path = "/nix/cfg";
        devices = [ "pc" "laptop" "phone" ];
        ignorePerms = false;
      };
      "Archive" = {
        path = "/synced/Archive";
        devices = [ "pc" "laptop" ];
        ignorePerms = false;
      };
      "Huge Archive" = {
        path = "/synced/Huge Archive";
        devices = [ "pc" ];
        ignorePerms = false;
      };
      "Ellida Sync" = {
        path = "/synced/Ellida Sync";
        devices = [ "pc" "laptop" ];
        ignorePerms = false;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "pc" "laptop" "phone" ];
        ignorePerms = false;
      };
    };
  };




}




