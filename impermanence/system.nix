{ ... }:


{

  environment.persistence."/nix/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager"
      "/etc/wpa_supplicant.conf"
      "/var/lib"
      "/var/log"

      "/etc/mullvad-vpn"
      "/etc/openvpn"
      #"/tmp"

      #"/root/.cache/nix"
    ];

    files = [
#      "/etc/machine-id"
#      "/etc/nix/id_rsa"
      #"/var/lib/yggdrasil/keys.json"
    ];
  };

  /*environment.persistence."/synced/Nix/cfg/persist/${config.networking.hostName}" = {
    directories = [
      "/etc/nixos"
    ];
  }; */

}
