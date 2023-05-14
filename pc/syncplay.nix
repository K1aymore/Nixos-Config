{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 60007 ];
    allowedUDPPorts = [ 60007 ];
  };

  services.syncplay = {
    enable = true;
    port = 60007;
  };

}
