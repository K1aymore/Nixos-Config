{ pkgs, lib, config, ... }:


{

  services.kubo = {
    enable = true;
    #startWhenNeeded = true;
    dataDir = "/synced/other/ipfs";
    localDiscovery = true;
    settings.Addresses = {
      Gateway = "/ip4/127.0.0.1/tcp/8081";
      API = [
        "/ip4/127.0.0.1/tcp/5001"
      ];
      Swarm = [
        "/ip4/0.0.0.0/tcp/59271"
        "/ip6/::/tcp/59271"
        "/ip4/0.0.0.0/udp/59271/quic"
        "/ip6/::/udp/59271/quic"
      ];
    };

  };

  users.users.klaymore.extraGroups = [ config.services.kubo.group ];

}
