{ config, lib, pkgs, ... }:

{

  services.freshrss = {
    enable = true;
    baseUrl = "https://klaymore.me/freshrss";
    dataDir = "/zfs2/servers/freshrss";
    passwordFile = "/zfs2/servers/freshrssPassword";
  };

  services.nginx.virtualHosts."klaymore.me".locations = {
    "/freshrss" = {
      root = "/zfs2/servers/freshrss";
    };

    "~ .php$" = {
      # ~ .php$
      # index = "index.php";
      extraConfig = ''
        # fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # include ${pkgs.nginx}/conf/fastcgi_params;
        # include ${pkgs.nginx}/conf/fastcgi.conf;
        fastcgi_pass unix:${config.services.phpfpm.pools.php.socket};
        fastcgi_index index.html;
      '';
    };
  };


  services.phpfpm.pools.php = {
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


  users.users.php = {
    isSystemUser = true;
    createHome = false;
    group = "php";
  };

  users.groups.php = {
    gid = 997;
  };

}
