{ ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ ports.miniflux ];

  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/zfs2/servers/minifluxCredentials";
    config = {
      LISTEN_ADDR = "0.0.0.0:${toString ports.miniflux}";
    };
  };

}