{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.servers.jellyfin.enable {

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "/zfs2/servers/jellyfin";
    };
  };
}