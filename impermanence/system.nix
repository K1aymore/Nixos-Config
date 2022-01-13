{ config, pkgs, ... }:


let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{

  imports = [ "${impermanence}/nixos.nix" ];


  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/etc/wpa_supplicant.conf"
      "/var/log"
      "/var/lib"
    ];

    files = [
#      "/etc/machine-id"
      "/etc/nix/id_rsa"
    ];
  };


}
