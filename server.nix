{ config, ... }:

{

  klaymore = {
    localIP = config.klaymore.serverLan;

    system = {
      impermanence.home.enable = true;
      impermanence.system.enable = true;
      zram.enable = true;
      zfs.enable = true;
    };

    pipewire.enable = true;
    
    programs = {
    };

    services = {
      ssh.listen.enable = true;
      syncthing.enable = true;
      wireguard-forwarding.enable = true;
    };

    servers = {
      forgejo.enable = true;
      minecraft.enable = true;
      nfs.enable = true;
      nginx.enable = true;
    };
  };

  networking = {
    hostId = "03828261";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 6900; to = 6999; } ];

  programs.java.enable = true;


}
