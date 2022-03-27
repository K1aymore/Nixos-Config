{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57213 ];
    allowedUDPPorts = [ 57213 ];
  };

  # uses port 7070 for console
  services.i2pd = {
    enable = true;
    port = 57213;
    enableIPv6 = true;
    nat = false;
    ntcp = false;
    ssu = false;
    bandwidth = 2700;

    dataDir = "/synced/other/.i2pd";

  };
}
