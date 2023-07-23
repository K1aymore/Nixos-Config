{ home-manager, impermanence, ... }:


{
  imports = [
    home-manager.nixosModule
    impermanence.nixosModule
  ];

  environment.persistence."/synced/Nix/persist/system" = {
    directories = [
      "/etc/NetworkManager"
      "/etc/wpa_supplicant.conf"
      "/var/lib"
      "/var/log"

      "/etc/mullvad-vpn"
      "/tmp"

      "/root/.cache/nix"
    ];

    files = [
#      "/etc/machine-id"
#      "/etc/nix/id_rsa"
    ];
  };

  /*environment.persistence."/synced/Nix/cfg/persist/${config.networking.hostName}" = {
    directories = [
      "/etc/nixos"
    ];
  }; */

}
