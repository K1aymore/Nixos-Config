{ pkgs, lib, config, ... }:

let
  app = "httpd";
  domain = "klaymore.me";
  dataDir = "/synced/Projects/Websites/klaymore.me";
in {

  networking.firewall.allowedTCPPorts = [ 80 443 ];


  services.httpd = {
    enable = true;
    adminAddr = "klaymorer@protonmail.com";

    extraModules = [
#       {name = "php7"; path = "${pkgs.php}/modules/libphp7.so";}
#       "http2"
    ];
    enablePHP = true;

    virtualHosts.${domain} = {
      addSSL = false;
      hostName = domain;

      documentRoot = dataDir;
#       locations."= /.well-known/matrix/server".extraConfig =
#         let
          # use 443 instead of the default 8448 port to unite
          # the client-server and server-server port for simplicity
#           server = { "m.server" = "matrix.klaymore.me:443"; };
#         in ''
#           add_header Content-Type application/json;
#           return 200 '${builtins.toJSON server}';
#         '';
    };
  };


  users.users.${app} =
  {
    isSystemUser = true;
  };


}
