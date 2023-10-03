{ config, pkgs, ...}:

{

  services.restya-board = {
    enable = true;

    dataDir = "/nix/persist/server/restyaboard";

    virtualHost = {
      listenHost = "172.16.0.0";
    };
    
  };



}
