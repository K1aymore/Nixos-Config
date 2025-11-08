{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.system.impermanence.system.enable {

    environment.persistence."/nix/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager"
        "/etc/wpa_supplicant.conf"
        "/var/lib"
        "/var/log"

        "/etc/mullvad-vpn"
        "/etc/openvpn"
        #"/etc/ssh"
        #"/tmp"
      ];

      files = [
        # "/etc/machine-id"
        # "/etc/nix/id_rsa"
        #"/var/lib/yggdrasil/keys.json"
      ];
    };
  
  };
}