{ pkgs, lib, config, ... }:


{

  services.ipfs = {
    enable = true;
    dataDir = "/nix/persist/ipfs";
    localDiscovery = true;
    gatewayAddress = "/ip4/127.0.0.1/tcp/8081";
  };

}
