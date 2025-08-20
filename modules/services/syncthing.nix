{ config, lib, ports, ... }:

let 
  syncFolder = name: { devices, path ? "/synced/${name}", ignorePerms ? false }: {
    enabled = builtins.elem config.networking.hostName devices;
    inherit devices path ignorePerms;
  };
in
{

  config = lib.mkIf config.klaymore.services.syncthing.enable {

    networking.firewall.allowedTCPPorts = [
      ports.syncthingTransfer
      ports.syncthingRelay
    ];

    services.syncthing = {
      enable = true;
      dataDir = "/synced";
      configDir = "/synced/persist/appdata/syncthing";
      user = "klaymore";
      group = "users";
      overrideDevices = true;
      overrideFolders = true;
      settings.devices = {
        "server" = { id = "S6R4I6V-STTDG4D-6X45NCM-MQGF4O7-DTYMQH4-S76ZREL-BWHB7XE-SDTALQC"; };
        "pc" = { id = "AT7GLBF-ZC7D5FF-4JZZ7XO-VWXM5KJ-CCERYXK-6UURHEF-UZWQ5GZ-HCYDDQG"; };
        "laptop" = { id = "HWIDO3Z-CKW43X3-X2HDWO5-GQXU6ZD-JVT2QBF-QLXXOHY-4D4LKQ7-ZRDNYQK"; };
        "pixel" = { id = "TM2BIPF-O53YVKR-56UEPPB-E5CU3GC-SX2YXZK-LMQEKG7-F74KCLH-CHFWGAW"; };
        "pixel-5" = { id = "Y4NMW6P-6WFPYZS-27ZSHPP-M4C5I2W-6RODJY3-INLKVLD-TD7MCJO-BBOZAAW"; };
      };

      settings.folders = builtins.mapAttrs syncFolder {
        "Archive" = {
          devices = [ "server" "pc" ];
        };
        "NixCfg" = {
          devices = [ "server" "pc" "laptop" "pixel" "pixel-5" ];
          ignorePerms = false;
          path = "/synced/Nix/cfg";
        };
        "Ellida Projects" = {
          devices = [ "server" "pc" "laptop" ];
          ignorePerms = true;
        };
        "Ellida Sync" = {
          devices = [ "server" "pc" ];
          ignorePerms = true;
        };
        "Media" = {
          devices = [ "server" "pc" "laptop" "pixel" "pixel-5" ];
        };
        "Projects" = {
          devices = [ "server" "pc" "laptop" ];
        };
        "Sync" = {
          devices = [ "server" "pc" "laptop" "pixel" "pixel-5" ];
        };
      };

    };

  };

}
