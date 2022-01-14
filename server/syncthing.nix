{ config, pkgs, ... }:


{

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
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "portable" = { id = "L5D2A3L-MEEXKHK-ZGL3YNN-2JFJSEA-LXSNJOO-DYTOFDH-WVEXAZB-675DZAL"; };
      "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
      "cDesk" = { id = "RLFHUVQ-HXAGZ54-DGEN2S3-YRHRWID-D6Q4S4B-PNOCIDP-T2NNWZP-GPY5NQG"; };
    };
    folders = {
      "Sync" = {
        path = "/synced/Sync";
        devices = [ "pc" "portable" "laptop" "phone" ];
        ignorePerms = false;
      };
      "Dotfiles" = {
        path = "/nix/dotfiles";
        devices = [ "pc" "portable" "laptop" ];
        ignorePerms = false;
      };
      "NixCfg" = {
        path = "/nix/cfg";
        devices = [ "pc" "portable" "laptop" "phone" ];
        ignorePerms = false;
      };
#       "NixPersist" = {
#         path = "/nix/persist";
#         devices = [ "pc" "laptop" ];
#         ignorePerms = false;
#       };
      "Projects" = {
        path = "/synced/Projects";
        devices = [ "pc" "portable" "laptop" ];
        ignorePerms = false;
      };
      "Archive" = {
        path = "/synced/Archive";
        devices = [ "pc" "portable" ];
        ignorePerms = false;
      };
      "Huge Archive" = {
        path = "/synced/Huge Archive";
        devices = [ "pc" ];
        ignorePerms = false;
      };
      "Ellida Sync" = {
        path = "/synced/Ellida Sync";
        devices = [ "pc" "portable" "laptop" "cDesk" ];
        ignorePerms = false;
      };
      "Ellida Projects" = {
        path = "/synced/Ellida Projects";
        devices = [ "pc" "portable" "laptop" "cDesk" ];
        ignorePerms = true;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "pc" "portable" "laptop" "phone" ];
        ignorePerms = false;
        rescanInterval = 30;
      };
    };
  };




}























