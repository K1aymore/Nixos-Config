{ pkgs, lib, config, ... }:


{

  networking.firewall = {
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 25565 ];
  };

  services.syncplay = {
    enable = true;
    port = 25565;
  };

}
