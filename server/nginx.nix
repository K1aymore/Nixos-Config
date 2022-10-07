{ pkgs, lib, config, ... }:

let
  app = "php";
  domain = "klaymore.me";
  datadir = "/synced/Projects/Websites/klaymore.me/_site";
in {

  networking.firewall.allowedTCPPorts = [ 80 443 ];


  security.acme = {
    acceptTerms = true;
    defaults.email = "klaymorer@protonmail.com";
    certs = {
      "klaymore.me" = {
        webroot = pkgs.lib.mkForce datadir;
        extraDomainNames = [ "matrix.klaymore.me" ];
        email = "klaymorer@protonmail.com";
      };
    };
  };


  services.nginx = {
    enable = true;
    resolver.addresses = [ "8.8.8.8" "8.8.4.4" ];

    virtualHosts.${domain} = {
      enableACME = true;
      addSSL = true;
      root = datadir;

      locations = {
        "/" = {
          index = "index.html";
          root = datadir;
        };

        "~ .php$" = {     # ~ .php$
#           index = "index.php";
          extraConfig = ''
#             fastcgi_split_path_info ^(.+\.php)(/.+)$;
#             include ${pkgs.nginx}/conf/fastcgi_params;
#             include ${pkgs.nginx}/conf/fastcgi.conf;
            fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
            fastcgi_index index.html;
          '';
        };
      };
    };

    virtualHosts."shorecraft.club" = {
      root="/synced/Projects/Websites/shorecraft.club";
      locations."/" = {
        return = "301 https://klaymore.me";
      };
    };

  };



  # phpfpm fails to start for me
#   services.phpfpm.settings = {
#     "user" = app;
#     "group" = app;
#   };

  services.phpfpm.pools.${app} = {
    user = "klaymore";
    settings = {
      "listen.owner" = config.services.nginx.user;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 5;
      "php_admin_value[error_log]" = "stderr";
      "php_admin_flag[log_errors]" = true;
      "catch_workers_output" = true;
    };
    phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
  };



  users.users.${app} = {
    isSystemUser = true;
    createHome = false;
    home = datadir;
    group  = app;
  };
  users.groups.${app} = {
    gid = 997;
  };
  users.groups.klaymore = {
    gid = 996;
  };

}
