{ ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ ports.miniflux ];

  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/zfs2/minifluxCredentials";
    config = {
      LISTEN_ADDR = "localhost:${toString ports.miniflux}";
    };
  };

}