{ ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ ports.forgejo ];

  security.pam.sshAgentAuth.enable = true;

  services.forgejo = {
    enable = true;

    stateDir = "/zfs2/servers/forgejo/state";
    repositoryRoot = "/zfs2/servers/forgejo/repository";

    settings = {
      service = {
        DISABLE_REGISTRATION = true;
      };
      server = {
        DOMAIN = "serverlan";
        HTTP_PORT = ports.forgejo;
        SSH_PORT = ports.ssh;
        DISABLE_HTTP_GIT = true;
      };
    };
  };

}
