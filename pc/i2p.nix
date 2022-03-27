{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57213 ];
    allowedUDPPorts = [ 57213 ];
  };

  # uses port 7657 for console
  # data in /var/lib/i2p
  services.i2p.enable = true;

}
