{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57227 ];
    allowedUDPPorts = [ 57227 ];
  };

  services.syncplay = {
    enable = true;
    port = 57227;
  };

}
