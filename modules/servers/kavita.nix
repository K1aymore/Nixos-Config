{ config, lib, pkgs, ports, ... }:

{
  config = lib.mkIf config.klaymore.servers.kavita.enable {

    networking.firewall.allowedTCPPorts = [ ports.kavita ];

    services.kavita = rec {
      enable = true;
      dataDir = config.klaymore.serversPath + "/kavita";
      tokenKeyFile = dataDir + "/tokenKeyFile"; # head -c 64 /dev/urandom | base64 --wrap=0
      settings = {
        Port = ports.kavita;
      };
    };

  };
}
