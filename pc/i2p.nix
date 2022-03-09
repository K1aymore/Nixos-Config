{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57213 ];
    allowedUDPPorts = [ 57213 ];
  };

  # uses port 7657 for console
  services.i2p.enable = true;

}
