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
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
      "laptop" = { id = "34AVXMA-IPYWWB6-42RQTSB-KKWKSN5-MYUB4II-AJBV5WI-OWG65XZ-FDZKMA3"; };
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
#       "NixPersist" = {
#         path = "/nix/persist";
#         devices = [ "server" "pc" "laptop" ];
#         ignorePerms = false;
#       };
      "Projects" = {
        path = "/synced/Projects";
        devices = [ "server" "pc" "laptop" ];
        ignorePerms = false;
      };
      "Archive" = {
        path = "/synced/Archive";
        devices = [ "server" "pc" "laptop" ];
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




