{ config, lib, ... }:

{
  config = lib.mkIf config.klaymore.servers.syncplay.enable {

    services.syncplay = {
      enable = true;
      isolateRooms = true;
    };

  };
}