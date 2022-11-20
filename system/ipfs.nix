{ pkgs, lib, config, ... }:


{

  services.kubo = {
    enable = true;
    #startWhenNeeded = true;
    dataDir = "/synced/other/ipfs";
    localDiscovery = true;
    settings.Addresses = {
      Gateway = "/ip4/127.0.0.1/tcp/8081";
      Swarm = [
      "/ip4/0.0.0.0/tcp/54903"
      "/ip6/::/tcp/54903"
      "/ip4/0.0.0.0/udp/54903/quic"
      "/ip6/::/udp/54903/quic"
      ];
    };

  };

}
