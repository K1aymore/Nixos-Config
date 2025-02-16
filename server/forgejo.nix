{ ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ ports.forgejo ];


  services.forgejo = {
    enable = true;

    stateDir = "/zfs2/servers/forgejo/state";
    repositoryRoot = "/zfs2/servers/forgejo/repository";

    database.passwordFile = "/zfs2/servers/forgejo/password";

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
      server = {
        HTTP_PORT = ports.forgejo;
        SSH_PORT = ports.ssh;
      };
    };
  };

}
