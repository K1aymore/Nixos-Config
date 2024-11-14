{ config, lib, ... }:

let 
  syncFolder = name: { devices, path ? "/synced/${name}", ignorePerms ? false }: {
    enabled = builtins.elem config.networking.hostName devices;
    devices = devices;
    path = path;
    ignorePerms = ignorePerms;
  };
in
{

  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    overrideDevices = true;
    overrideFolders = true;
    settings.devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "7K7FUNH-GHCYAXJ-4PNRNKS-5KRRCBF-MBE5YOT-NQ6CHMJ-2G4FMAJ-SG22GQJ"; };
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "pixel" = { id = "TM2BIPF-O53YVKR-56UEPPB-E5CU3GC-SX2YXZK-LMQEKG7-F74KCLH-CHFWGAW"; };
    };

    settings.folders = lib.attrsets.mapAttrs syncFolder {
      Archive = {
        devices = [ "server" "pc" ];
      };
      Cfg = {
        devices = [ "server" "pc" "laptop" "pixel" ];
        ignorePerms = false;
      };
      Dotfiles = {
        devices = [ "server" "pc" "laptop"] ;
      };
      EllidaProjects = {
        devices = [ "server" "pc" "laptop" ];
        ignorePerms = true;
      };
      EllidaSync = {
        devices = [ "server" "pc" ];
        ignorePerms = true;
      };
      Media = {
        devices = [ "server" "pc" "laptop" "pixel" ];
      };
      Projects = {
        devices = [ "server" "pc" "laptop" ];
      };
      Sync = {
        devices = [ "server" "pc" "laptop" "pixel" ];
      };
    };

  };

}
