 
{ pkgs, lib, ... }:

{

  networking.firewall.allowedTCPPorts = [ 5232 ];


  services.nginx.virtualHosts."radicale.klaymore.me" = {
    enableACME = true;
    addSSL = true;
    forceSSL = false;

    locations."/radicale/" = {        # reverse proxy, passes http authentication headers
      proxy_pass = "http://localhost:5232/";
      proxy_set_header."X-Script-Name" = "/radicale";
      proxy_set_header."X-Forwarded-For" = "$proxy_add_x_forwarded_for";
      proxy_set_header."X-Remote-User" = "$remote_user";
      proxy_set_header."Host" = "$http_host";
      auth_basic = "Radicale - Password Required";
      auth_basic_user_file = "/nix/persist/server/radicale/users";
    };
  };



  services.radicale = {
    enable = true;

    settings = {
      server = {
        hosts = [ "0.0.0.0:5232" "[::]:5232" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/nix/persist/server/radicale/users";
        htpasswd_encryption = "md5";
      };
      storage = {
        filesystem_folder = "/nix/persist/server/radicale/files";
      };
    };

  };


}
