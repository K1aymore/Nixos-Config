{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 57701 ];
    allowedUDPPorts = [ 57701 ];
  };

  services.syncplay = {
    enable = true;
    port = 57701;
  };

}
