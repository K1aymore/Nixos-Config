{ config, pkgs, ... }:


let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{

  imports = [ "${impermanence}/nixos.nix" ];


  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/NetworkManager"
      "/etc/wpa_supplicant.conf"
      "/var/log"
      "/var/lib"

      "/etc/mullvad-vpn"
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
