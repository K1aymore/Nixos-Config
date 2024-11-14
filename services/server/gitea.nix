{ pkgs, lib, ... }:

{

  networking.firewall.allowedTCPPorts = [ 3000 ];

  /* services.nginx = {
    enable = true;
    # only recommendedProxySettings and recommendedGzipSettings are strictly required,
    # but the rest make sense as well
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {

       # Reverse proxy for Matrix client-server and server-server communication
       "klaymore.me" = {
#         enableACME = true;
#         addSSL = true;
#         forceSSL = true;
# #         root = "/synced/Projects/Websites/gitea.klaymore.me";

#         # Or do a redirect instead of the 404, or whatever is appropriate for you.
#         # But do not put a Matrix Web client here! See the Element web section below.
# #         locations."/".extraConfig = ''
# #           return 404;
# #         '';

#         # forward all Matrix API calls to the synapse Matrix homeserver
          locations."/gitea" = {
            proxyPass = "http://[::1]:3000"; # without a trailing /
          };
       };
    };
  }; */



  services.gitea = {
    enable = true;

    stateDir = "/zfs2/gitea/state";
    repositoryRoot = "/zfs2/gitea/repository";

    database.passwordFile = "/zfs2/gitea/password";

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };




}
