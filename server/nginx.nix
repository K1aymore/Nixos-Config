{ pkgs, lib, config, ports, ... }:

let
  #domain = "klaymore.me";
  datadir = "/synced/Projects/Websites/nix-site/result";
in
{

  networking.firewall.allowedTCPPorts = [ ports.nginx ports.nginxs ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "klaymorer@protonmail.com";
    certs."klaymore.me" = {
      email = "klaymorer@protonmail.com";
    };
  };


  services.nginx = {
    enable = true;
    #resolver.addresses = [ "8.8.8.8" "8.8.4.4" ];

    virtualHosts."klaymore.me" = {
      addSSL = true;
      enableACME = true;
      root = datadir;

    };

    virtualHosts."shorecraft.club" = {
      root = "/synced/Projects/Websites/shorecraft.club";
      locations."/" = {
        return = "301 https://klaymore.me";
      };
    };

  };



  users.groups.klaymore = {
    gid = 996;
  };

}
