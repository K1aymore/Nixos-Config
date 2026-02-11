{ config, ... }:

{

  klaymore = {
    localIP = config.klaymore.serverLan;

    pipewire.enable = true;

    programs = {
    };
    
    servers = {
      forgejo.enable = true;
      kavita.enable = true;
      # minecraft.enable = true;
      nfs.enable = true;
      nginx.enable = true;
      wireguard-forwarding.enable = true;
    };

    services = {
      ssh.listen.enable = true;
      syncthing.enable = true;
    };

    system = {
      #impermanence.home.enable = true;
      impermanence.system.enable = true;
      kanata.enable = true;
      locale = "en_US.UTF-8";
      zram.enable = true;
      zfs.enable = true;
    };

  };

  networking = {
    hostId = "03828261";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedTCPPortRanges = [ { from = 6900; to = 6999; } ];

  programs.java.enable = true;


}
