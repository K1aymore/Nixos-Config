{ lib, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ (lib.strings.toIntBase10 (builtins.readFile "/synced/cfg/_secrets/i2pport")) 7070 ];
  };

  # uses port 7070 for console
  services.i2pd = {
    enable = true;
    port = (lib.strings.toIntBase10 (builtins.readFile "/synced/cfg/_secrets/i2pport"));
    enableIPv6 = true;
    nat = false;
    #ntcp = false;
    #ssu = false;
    bandwidth = 2700;

    dataDir = "/synced/other/.i2pd";

  };
}
