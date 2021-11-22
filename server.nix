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
        #54653
      ];

      allowedUDPPorts = [
        21027   # Syncthing discovery
        #53675
      ];

    };
  };




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


#   security.acme.certs = {
#     "klaymore.me" = {
#       directory = "/nix/persist/server/acmeCerts/klaymore.me";
#       webroot = "/synced/Websites/klaymore.me";
#       email = "klaymorer@protonmail.com";
#       extraDomainNames = [ "matrix.klaymore.me" ];
#     };
#   };

  security.acme.email = "klaymorer@protonmail.com";
  security.acme.acceptTerms = true;


}




