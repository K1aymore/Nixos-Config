{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 58819 ];
    allowedUDPPorts = [ 58819 ];
  };

  services.syncplay = {
    enable = true;
    port = 58819;
  };

}
