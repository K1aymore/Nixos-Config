{ config, pkgs, ... }:


let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  sys = /nix/persist/system;
in
{

  imports = [ "${impermanence}/nixos.nix" ];

  /*
  fileSystems."/etc/NetworkManager" = {
    device = "/nix/persist/system/NetworkManager";
    options = [ "bind" ];
  };
  fileSystems."/etc/wpa_supplicant.conf" = {
    device = "/nix/persist/system/wpa_supplicant.conf";
    options = [ "bind" ];
  };
  fileSystems."/var/log" = {
    device = "/nix/persist/system/var-log";
    options = [ "bind" ];
  };
  fileSystems."/var/lib" = {
    device = "/nix/persist/system/var-lib";
    options = [ "bind" ];
  };

  fileSystems."/etc/mullvad-vpn" = {
    device = "/nix/persist/system/mullvad-vpn";
    options = [ "bind" ];
  };
  fileSystems."/tmp" = {
    device = "/nix/persist/system/tmp";
    options = [ "bind" ];
  };


  fileSystems."/etc/nixos" = {
    device = "/nix/cfg/persist/${config.networking.hostName}/etc/nixos";
    options = [ "bind" ];
  };
  */

  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/NetworkManager"
      "/etc/wpa_supplicant.conf"
      "/var/lib"
      "/var/log"

      "/etc/mullvad-vpn"
      "/tmp"

      "/root/.local/share/DaVinciResolve"
    ];

    files = [
#      "/etc/machine-id"
#       "/etc/nix/id_rsa"
    ];
  };

  environment.persistence."/nix/cfg/persist/${config.networking.hostName}" = {
    directories = [
      "/etc/nixos"
    ];
  };

}
