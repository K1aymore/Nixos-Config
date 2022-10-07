{ pkgs, lib, config, ... }:


{

  services.kubo = {
    enable = true;
    dataDir = "/synced/other/ipfs";
    localDiscovery = true;
    gatewayAddress = "/ip4/127.0.0.1/tcp/8081";
    #startWhenNeeded = true;

    swarmAddress = [
    "/ip4/0.0.0.0/tcp/54903"
    "/ip6/::/tcp/54903"
    "/ip4/0.0.0.0/udp/54903/quic"
    "/ip6/::/udp/54903/quic"
    ];
  };

}
