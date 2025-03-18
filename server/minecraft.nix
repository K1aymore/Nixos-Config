{ pkgs, ports, ... }:

{

  networking.firewall.allowedTCPPorts = [ 25565 ports.minecraft-wildcat ];


  # tmux -S /run/minecraft/servername.sock attach, press Ctrl + b then d to detach.

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/zfs2/servers/minecrafts";

    servers = {
      wildcat-gamer-haven = {
        enable = true;
        package = pkgs.vanillaServers.vanilla-1_21_4;
        jvmOpts = "-Xmx8192M -Xms8192M";

        serverProperties = {
          motd = "Wildcat Gamer Heaven";
          white-list = false;
          difficulty = 2;
          gamemode = 0;
          max-players = 25;
          allow-flight = true;
          server-port = ports.minecraft-wildcat;
        };
        whitelist = {
          klaymor = "23ca81b5-5e74-47cd-93f9-766b2c721b4e";
          FAIRFAX100 = "7c3ad143-be71-4a89-a6c7-5de1f241df85";
          Pink_Laser_Beam = "01f9ed0a-c79d-4815-bbf2-1a94d2d70e43";
          troysh = "90eb6c3d-1055-4ae0-b5b0-c6b4cfb2429b"; # Eli
        };
      };
    };
  };


}
