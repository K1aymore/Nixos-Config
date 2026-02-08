{ config, lib, ports, ... }:

{
  config = lib.mkIf config.klaymore.servers.kavita.enable {

    networking.firewall.allowedTCPPorts = [ ports.kavita ];

    services.kavita = {
      enable = true;
      dataDir = "/zfs2/servers/kavita";
      settings = {
        Port = ports.kavita;
      };
    };

  };
}
