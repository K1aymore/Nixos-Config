{ ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 56338 7070 ];
    allowedUDPPorts = [ 56338 7070 ];
  };

  # uses port 7070 for console
  services.i2pd = {
    enable = true;
    port = 56338;
    enableIPv6 = true;
    nat = false;
    #ntcp = false;
    #ssu = false;
    bandwidth = 2700;

    dataDir = "/synced/other/.i2pd";

  };
}
