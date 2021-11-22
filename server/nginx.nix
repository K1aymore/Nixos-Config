 
{ pkgs, lib, ... }:

{

  networking.firewall.allowedTCPPorts = [ 80 443 ];

#   security.acme.certs = {
#     "klaymore.me" = {
#       directory = "/nix/persist/server/acmeCerts/klaymore.me";
#       webroot = "/synced/Websites/klaymore.me";
#       email = "klaymorer@protonmail.com";
#       extraDomainNames = [ "matrix.klaymore.me" ];
#     };
#   };

  services.nginx = {
    enable = true;
    
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  
    virtualHosts."klaymore.me" = {
      enableACME = true;
      addSSL = true;
      root = "/synced/Websites/klaymore.me";
    };
  };


}
