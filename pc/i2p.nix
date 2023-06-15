{ ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 56338 ];
    allowedUDPPorts = [ 56338 ];
  };

  # uses port 7657 for console
  # data in /var/lib/i2p
  services.i2p.enable = true;

}
