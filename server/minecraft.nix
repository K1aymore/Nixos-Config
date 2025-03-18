{ pkgs, ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ 25565 ports.minecraft-wildcat ];


  # tmux -S /run/minecraft/servername.sock attach, press Ctrl + b then d to detach.

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/zfs2/servers/minecrafts";

    servers.wildcat-gamer-haven = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_4;
      jvmOpts = "-Xmx8192M -Xms8192M";

      serverProperties = {
        motd = "Wildcat Gamer Heaven";
        white-list = false;
        difficulty = 2;
        gamemode = 0;
        max-players = 25;
        allow-flight = true;
        server-port = ports.minecraft-wildcat;
        spawn-protection = 0;
      };

      whitelist = {
        klaymor = "23ca81b5-5e74-47cd-93f9-766b2c721b4e";
        FAIRFAX100 = "7c3ad143-be71-4a89-a6c7-5de1f241df85";
        Pink_Laser_Beam = "01f9ed0a-c79d-4815-bbf2-1a94d2d70e43";
        troysh = "90eb6c3d-1055-4ae0-b5b0-c6b4cfb2429b"; # Eli
        djurilol = "078d6fe6-8901-4fa8-bb25-344535b281ca";
        eli_shmeli = "8f6ee452-f933-48a6-8e7b-294013d1876b";
        PifflePoffle = "07a50b00-cde9-431e-a909-ccff7e21ed57";
        Denpants = "0a0e0766-bc44-498c-b039-49979d4a5507";
      };

      symlinks."mods/Distant Horizons.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uCdwusMi/versions/DTFSZmMF/DistantHorizons-neoforge-fabric-2.3.0-b-1.21.4.jar";
        sha512 = "7337d486cde3dd43f5bed5f81277170d0dab4257f5d355e1dc88d5cfb5577a8592a35a3df80d35e1ec81b799ebc7b398c348cec6e73a0d37e7952883e49d06dd";
      };
    };
  };


}
