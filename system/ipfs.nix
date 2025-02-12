{ config, ports, ... }:

{

  services.kubo = {
    enable = true;
    #startWhenNeeded = true;
    dataDir = "/synced/other/ipfs";
    localDiscovery = true;
    settings.Addresses = {
      Gateway = "/ip4/127.0.0.1/tcp/${ports.ipfsGateway}";
      API = [
        "/ip4/127.0.0.1/tcp/${ports.ipfsAPI}"
      ];
      Swarm = [
        "/ip4/0.0.0.0/tcp/${ports.ipfs}"
        "/ip6/::/tcp/${ports.ipfs}"
        "/ip4/0.0.0.0/udp/${ports.ipfs}/quic"
        "/ip6/::/udp/${ports.ipfs}/quic"
      ];
    };

  };

  users.users.klaymore.extraGroups = [ config.services.kubo.group ];

}
