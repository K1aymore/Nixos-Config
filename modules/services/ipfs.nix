{ config, lib, ports, ... }:

{

  config = lib.mkIf config.klaymore.services.ipfs.enable {

    services.kubo = {
      enable = true;
      #startWhenNeeded = true;
      dataDir = "/synced/other/ipfs";
      localDiscovery = true;
      settings.Addresses = {
        Gateway = "/ip4/127.0.0.1/tcp/${toString ports.ipfsGateway}";
        API = [
          "/ip4/127.0.0.1/tcp/${toString ports.ipfsAPI}"
        ];
        Swarm = [
          "/ip4/0.0.0.0/tcp/${toString ports.ipfs}"
          "/ip6/::/tcp/${toString ports.ipfs}"
          "/ip4/0.0.0.0/udp/${toString ports.ipfs}/quic"
          "/ip6/::/udp/${toString ports.ipfs}/quic"
        ];
      };

    };

    users.users.klaymore.extraGroups = [ config.services.kubo.group ];

  };
}
