{ pkgs, ports, ... }:

let
  # config.networking.domain = "klaymore.me";
  # fqdn =
  #   let
  #     join = hostName: domain: hostName + lib.optionalString (domain != null) ".${domain}";
  #   in
  #   join config.networking.hostName config.networking.domain;
  # url = "matrix.klaymore.me";
in
{

  networking.firewall.allowedTCPPorts = [ 80 443 ports.synapse ];

  services.postgresql.enable = true;
  services.postgresql.initialScript = pkgs.writeText "synapse-init.sql" ''
    CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
    CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
      TEMPLATE template0
      LC_COLLATE = "C"
      LC_CTYPE = "C";
  '';

  #security.acme.certs."klaymore.me".extraDomainNames = [ "matrix.klaymore.me" ];


  services.nginx = {
    enable = true;
    #recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "klaymore.me" = {
        locations."= /.well-known/matrix/server".extraConfig = # needed for reverse proxy
          let
            # use 443 instead of the default 8448 port to unite
            # the client-server and server-server port for simplicity
            server = { "m.server" = "matrix.klaymore.me:${toString ports.nginxs}"; };
          in
          ''
            add_header Content-Type application/json;
            return 200 '${builtins.toJSON server}';
          '';
      };

      # Reverse proxy for Matrix client-server and server-server communication
      "matrix.klaymore.me" = {
        addSSL = true;
        enableACME = true;
        root = "/synced/Projects/Websites/matrix.klaymore.me";
        # forward all Matrix API calls to the synapse Matrix homeserver
        locations = {
          "/" = {
            index = "index.html";
            root = "/synced/Projects/Websites/matrix.klaymore.me";
          };

          "^~ /.well-known/acme-challenge" = {
            root = "/synced/Projects/Websites/matrix.klaymore.me";
            extraConfig = ''
              allow all;
            '';
          };
          "/_matrix" = {
            proxyPass = "http://[::1]:${toString ports.synapse}"; # without a trailing /
          };
        };
      };
      
    };
  };

  services.coturn = {
    enable = true;
    no-cli = true;
    no-tcp-relay = true;
    min-port = 49000;
    max-port = 50000;
    use-auth-secret = true;
    static-auth-secret = "will be world readable for local users";
    realm = "matrix.klaymore.me";
    cert = "/zfs2/servers/coturn/full.pem";
    pkey = "/zfs2/servers/coturn/key.pem";
  };

  /*
    security.acme.certs."matrix.klaymore.me" = {
    /* insert here the right configuration to obtain a certificate
    postRun = "systemctl restart coturn.service";
    group = "turnserver";
    };
  */

  services.matrix-synapse = {
    enable = true;

    dataDir = "/zfs2/servers/synapse";
    # registration_shared_secret = "W72lPZDYLLc7vHL6z6uMm8lhrXZ6nz82skZo76bS0bd6fOPKB4fe9VJ8tPKQCqN3";

    settings = {
      turn_uris = [ "turn:matrix.klaymore.me:3478?transport=udp" "turn:matrix.klaymore.me:3478?transport=tcp" ];
      turn_shared_secret = "will be world readable for local users";
      turn_user_lifetime = "1h";

      max_upload_size = "50M";
      server_name = "klaymore.me";

      listeners = [{
        port = ports.synapse;
        bind_addresses = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = false;
        }];
      }];

    };
  };



}
