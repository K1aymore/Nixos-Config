{ pkgs, lib, ... }:

{

  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    openFirewall = true;
    /* package = pkgs.minecraft-fabric-server; */

    dataDir = "/nix/persist/server/Minecraft";
    jvmOpts = "-Xmx8192M -Xms8192M";


    whitelist = {
      klaymor = "23ca81b5-5e74-47cd-93f9-766b2c721b4e";
      FAIRFAX100 = "7c3ad143-be71-4a89-a6c7-5de1f241df85";
      Pink_Laser_Beam = "01f9ed0a-c79d-4815-bbf2-1a94d2d70e43";
    };


    serverProperties = {
      white-list = true;
      difficulty = 2;
      gamemode = 0;
      max-players = 10;
      allow-flight = true;
      motd = "Klaymore's Minecraft server!";
    };

  };


}
