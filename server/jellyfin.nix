{ ... }:

{

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/zfs2/servers/jellyfin";
  };

}
