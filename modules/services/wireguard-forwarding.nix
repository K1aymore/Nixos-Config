{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.services.wireguard-forwarding.enable {

  };
}