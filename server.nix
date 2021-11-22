{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix
      
      ./server/nginx.nix
      ./server/synapse.nix
      # ./server/vaultwarden.nix


      # ./system/xp-pen.nix

      # ./impermanence/system.nix
      # ./impermanence/home.nix
    ];



  networking = {
    hostName = "server";
    domain = "klaymore.me";

    firewall = {
      enable = true;

      allowedTCPPorts = [
        22000   # Syncthing transfers
        56789   # SSH
        #54653
      ];

      allowedUDPPorts = [
        21027   # Syncthing discovery
        56789   # SSH
        #53675
      ];

    };
  };


  services.openssh = {
    enable = true;
    ports = [ 56789 ];
    passwordAuthentication = false;
  };
 
  users.users.klaymore.openssh.authorizedKeys.keys = [
    # Phone connectbot
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCulFjLwB+PGnhY1l4a6S2wAzK/bf7b6lWkT1SKFvifxAKbU1/7OWVnYnpzjpXB3/9m6yevKvVUecCVBCZKMWjFlIB/WK8zwAaSopXb3+BhIrBhcfPvrNt4EeufLbtIDFnB0V46WNDVIPxqwWCe+dU39gP8SDEpkDza3dGx4Wf2hs7Vr9Oof2cRguv2BDqUJoRqgDkq6rrUWxRLxDDLwcWJfLtTsRLD9bIZy/1KtlcqfFZqV4HhjBz0LOv3iwHr9Bc1CCsvU/OVxzkUesXX7qvNDNiync3BQUwMzbSm6cAMhkcDULfBcdoPJZpmP9GPC2MiVDJgmr4DHV3PL96du1gIdhot+pew9uH/Do7k2mA/hTiV4G22wdWCNVFsQDzJHwHqI1fCOxutpgeqG6IvdbCx3BZH0ZVJnGgzcEUyCOevhAjdkoxKLoPxWDx/AK9fS6y+i7N9R4reptcySxPTVEenAf/DM2a1nxenU0tgtR/Ctp1h7JvvRsv1zs7u3pO8XxLi6DhfUYR3j4CfKNqnBYrrm+Vki9wO3p4rS6nHhKDhBF2AsLe/tnxPerfD++X7jMe4qJjeJ4RNw2jEDogFVE6Y/OBibKSanzGykU2H+C7tILs9w2dx9hq1nswgfs+/N7+JWE7qThSXJTSBMgA5edCWyM/QPWNaJpoIxoRUKo2zJQ== PC"
    
    # Laptop
    "ssh-rsa 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 /NgU55364N26LH3nbJNA4EAcrUQ= klaymore@klaymore-big"
    
    # PC
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFc73OGH6mAO6W51snCZCeatIbYfgPnzjUGA/HmEqbKHgdJqnbQpRp+qH7RuJWlWCaS24jTFqb6LRZRXbqmbaEjBTxYsg0I+UDU06KKwZa598CRSfVyTNbQr+HiczJhghmCcnQPAROF40SR37zhfzPU4wJzi+aOy1rvczuKLGcBBxWkxvjYTNtIREUule2rG46Wy1TT6DYqzNCnmgUaCH1C1qxL4AMM6NbSuAWFOyL7XenubUNoxXDTxD7GhW41wemHFsRVHgiCkXmK5A+92aVkLRrzQ1vkhqxkobbLT1V2aFbCHOaIWgDKKqpdD2uNvyBjOnWKWra0TZ7vFbuYopOa6Qf+LZP44yqWePKiBwfdpj5MITTdbhyHC+vCN+ZBxUnjsV+G7YFpP2NlFzxiqZiBRMWjyjmrtd9oeU6DVbrAfxOBp7NVG5nYWX52PE65KifEMRv0sx1tie243jGYJ1se3sWNNVDk8/LQI9xc2mecAZ639nuaU+zN3KM4wPwh+/U1O9c3ghTz0tJ7B98/5jMUMl3UHFC0puLkZpwVLpnVDbsZyja1dlghafYyP+IDclTMfAp6TPCco4kB64s8kIpfYB5JK/99UOVbuxiZqrsHYA1DmqxYKg+FtZKoDKjAozVUwaahvo/UDMfPjXltY1ogna2ndBNTZS1tcE5VKQiuw== klaymorer@pm.me"
  ];


  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    openDefaultPorts = true;
    user = "klaymore";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    declarative = {
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "laptop" = { id = "34AVXMA-IPYWWB6-42RQTSB-KKWKSN5-MYUB4II-AJBV5WI-OWG65XZ-FDZKMA3"; };
        "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
        "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
      };
      folders = {
        "Sync" = {
          path = "/synced/Sync";
          devices = [ "pc" "laptop" "phone" ];
          ignorePerms = false;
        };
        "NixCfg" = {
          path = "/nix/cfg";
          devices = [ "pc" "laptop" "phone" ];
          ignorePerms = false;
        };
        "Projects" = {
          path = "/synced/Projects";
          devices = [ "pc" "laptop" ];
          ignorePerms = false;
        };
        "Archive" = {
          path = "/synced/Archive";
          devices = [ "pc" "laptop" ];
          ignorePerms = false;
        };
        "Huge Archive" = {
          path = "/synced/Huge Archive";
          devices = [ "pc" ];
          ignorePerms = false;
        };
        "Ellida Sync" = {
          path = "/synced/Ellida Sync";
          devices = [ "pc" "laptop" ];
          ignorePerms = false;
        };
        "Websites" = {
          path = "/synced/Websites";
          devices = [ "pc" "laptop" "phone" ];
          ignorePerms = false;
        };
      };
    };
  };



  security.acme.email = "klaymorer@protonmail.com";
  security.acme.acceptTerms = true;


}




