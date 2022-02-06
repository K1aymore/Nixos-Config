{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57213 ];
    allowedUDPPorts = [ 57213 ];
  };

  services.i2p.enable = true;

}
