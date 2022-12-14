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
      "/var/lib"
      "/var/log"

      "/etc/mullvad-vpn"
      "/tmp"

      "/root/.local/share/DaVinciResolve"
    ];

    files = [
#      "/etc/machine-id"
#      "/etc/nix/id_rsa"
    ];
  };

  environment.persistence."/synced/Nix/cfg/persist/${config.networking.hostName}" = {
    directories = [
      "/etc/nixos"
    ];
  };

}
