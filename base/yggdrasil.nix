{ config, lib, pkgs, systemSettings, ... }:

{

  networking.firewall.allowedTCPPorts = [ systemSettings.yggdrasilPort ];

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    openMulticastPort = true;
    settings = {

      Listen = [
        "tcp://0.0.0.0:${toString systemSettings.yggdrasilPort}"
        "tcp://::${toString systemSettings.yggdrasilPort}"
      ];

      # Yggdrasil will automatically connect and "peer" with other nodes it
      # discovers via link-local multicast announcements. Unless this is the
      # case (it probably isn't) a node needs peers within the existing
      # network that it can tunnel to.
      #"tcp://1.2.3.4:1024"
      Peers = systemSettings.yggdrasilPeers;
      
      NodeInfo = {
        # This information is visible to the network.
        name = "Klaymore-" + config.networking.hostName;
        #location = "The North Pole";
      };
    };

  };



}
