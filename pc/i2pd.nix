{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57213 ];
    allowedUDPPorts = [ 57213 ];
  };

  # uses port 7657 for console
  services.i2pd = {
    enable = true;
    port = 57213;
    enableIPv6 = true;
    
    dataDir = "/synced/other/i2pd";

  };
}
