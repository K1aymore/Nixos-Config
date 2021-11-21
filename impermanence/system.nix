{ config, pkgs, ... }:


let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";

in
{

  imports = [
    (import "${impermanence}/nixos.nix")
  ];


  environment.persistence."/nix/persist/system" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/var/log"
      "/var/lib"
    ];

    files = [
      "/etc/machine-id"
      "/etc/nix/id_rsa"
    ];

  };


}
