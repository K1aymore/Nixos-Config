 
{ pkgs, lib, ... }:

{

  networking.firewall.allowedTCPPorts = [ 80 443 ];


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
