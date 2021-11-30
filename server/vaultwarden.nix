 {pkgs,...}:


{

  networking.firewall.allowedTCPPorts = [ 80 443 3012 ];

  security.acme.certs."vault.example.com" = {
    group = "vaultwarden";
    keyType = "rsa2048";
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "vault.klaymore.me" = {
        addSSL = true;
        enableACME = true;
#         locations."/" = {
#           proxyPass = "http://localhost:8812"; #changed the default rocket port due to some conflict
#           proxyWebsockets = true;
#         };
        locations."/notifications/hub" = {
          proxyPass = "http://localhost:3012";  # WebSocket port
          proxyWebsockets = true;
        };
#         locations."/notifications/hub/negotiate" = {
#           proxyPass = "http://localhost:8812";  # probably more rocket stuff
#           proxyWebsockets = true;
#         };
      };
    };
  };

  services.bitwarden_rs = {
    enable = true;
    backupDir = "/nix/persist/server/vaultwarden/backup";

    config = {
      WEB_VAULT_FOLDER = "/nix/persist/server/vaultwarden/webVault";
      WEB_VAULT_ENABLED = true;
      LOG_FILE = "/nix/persist/server/vaultwarden/logs";
      WEBSOCKET_ENABLED= true;
      WEBSOCKET_ADDRESS = "0.0.0.0";
      WEBSOCKET_PORT = 3012;
      SIGNUPS_ALLOWED=true;
#       SIGNUPS_VERIFY = true;
#       ADMIN_TOKEN = (import /etc/nixos/secret/bitwarden.nix).ADMIN_TOKEN;
      DOMAIN = "https://klaymore.me";
#       YUBICO_CLIENT_ID = (import /etc/nixos/secret/bitwarden.nix).YUBICO_CLIENT_ID;
#       YUBICO_SECRET_KEY = (import /etc/nixos/secret/bitwarden.nix).YUBICO_SECRET_KEY;
#       YUBICO_SERVER = "https://api.yubico.com/wsapi/2.0/verify";
#       SMTP_HOST = "mx.example.com";
#       SMTP_FROM = "bitwarden@example.com";
#       SMTP_FROM_NAME = "Bitwarden_RS";
#       SMTP_PORT = 587;
#       SMTP_SSL = true;
#       SMTP_USERNAME= (import /etc/nixos/secret/bitwarden.nix).SMTP_USERNAME;
#       SMTP_PASSWORD = (import /etc/nixos/secret/bitwarden.nix).SMTP_PASSWORD;
#       SMTP_TIMEOUT = 15;
#       ROCKET_PORT = 8812;
    };
  };

  environment.systemPackages = with pkgs; [
    bitwarden_rs-vault
  ];

}
