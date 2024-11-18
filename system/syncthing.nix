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
      "server" = { id = "S6R4I6V-STTDG4D-6X45NCM-MQGF4O7-DTYMQH4-S76ZREL-BWHB7XE-SDTALQC"; };
      "pc" = { id = "7K7FUNH-GHCYAXJ-4PNRNKS-5KRRCBF-MBE5YOT-NQ6CHMJ-2G4FMAJ-SG22GQJ"; };
      "laptop" = { id = "6QZH26V-YJTBBCI-VCEBW4Q-U6ILQA7-PLSWZ4W-YA3KWFQ-KSYTD4A-FS5SPQ7"; };
      "pixel" = { id = "TM2BIPF-O53YVKR-56UEPPB-E5CU3GC-SX2YXZK-LMQEKG7-F74KCLH-CHFWGAW"; };
    };

    settings.folders = lib.attrsets.mapAttrs syncFolder {
      "Archive" = {
        devices = [ "server" "pc" ];
      };
      "NixCfg" = {
        devices = [ "server" "pc" "laptop" "pixel" ];
        ignorePerms = false;
        path = "/synced/Nix/cfg";
      };
      #"dotfiles" = {
      #  devices = [ "server" "pc" "laptop" ] ;
      #  path = "/nix/dotfiles";
      #};
      "Ellida Projects" = {
        devices = [ "server" "pc" "laptop" ];
        ignorePerms = true;
      };
      "Ellida Sync" = {
        devices = [ "server" "pc" ];
        ignorePerms = true;
      };
      "Media" = {
        devices = [ "server" "pc" "laptop" "pixel" ];
      };
      "Projects" = {
        devices = [ "server" "pc" "laptop" ];
      };
      "Sync" = {
        devices = [ "server" "pc" "laptop" "pixel" ];
      };
    };

  };

}
