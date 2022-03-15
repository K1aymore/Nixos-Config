{ pkgs, lib, config, ... }:


{

  services.ipfs = {
    enable = true;
    dataDir = "/nix/persist/appdata/ipfs";
    localDiscovery = true;
    gatewayAddress = "/ip4/127.0.0.1/tcp/8081";
    startWhenNeeded = true;

    swarmAddress = [
    "/ip4/0.0.0.0/tcp/55434"
    "/ip6/::/tcp/55434"
    "/ip4/0.0.0.0/udp/55434/quic"
    "/ip6/::/udp/55434/quic"
    ];
  };

}
