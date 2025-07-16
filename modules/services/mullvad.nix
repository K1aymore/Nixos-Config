{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.services.mullvad.enable {
    networking.firewall.checkReversePath = "loose";
    networking.wireguard.enable = true;
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
  };
}