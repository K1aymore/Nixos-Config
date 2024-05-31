{ lib, ... }:


{

  networking.firewall = {
    #allowedTCPPorts = [ (lib.strings.toIntBase10 (builtins.readFile "/synced/Nix/cfg/_secrets/i2pport")) ];
  };

  # uses port 7657 for console
  # data in /var/lib/i2p
  services.i2p.enable = true;

}
