{ config, lib, ports, ... }:

{

  config = lib.mkIf config.klaymore.services.yggdrasil.enable {
    networking.firewall.allowedTCPPorts = [ ports.yggdrasil ];

    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      openMulticastPort = true;
      settings = {

        Listen = [
          "tcp://0.0.0.0:${toString ports.yggdrasil}"
          "tcp://::${toString ports.yggdrasil}"
        ];

        # Yggdrasil will automatically connect and "peer" with other nodes it
        # discovers via link-local multicast announcements. Unless this is the
        # case (it probably isn't) a node needs peers within the existing
        # network that it can tunnel to.
        #"tcp://1.2.3.4:1024"
        Peers = config.klaymore.services.yggdrasil.peers;
        
        NodeInfo = {
          # This information is visible to the network.
          name = "Klaymore-" + config.networking.hostName;
          #location = "The North Pole";
        };
      };

    };

  };
}