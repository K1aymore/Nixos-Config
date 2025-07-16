{ config, lib, pkgs, ports, ... }:

{

  config = lib.mkIf config.klaymore.servers.minecraft.enable {

    networking.firewall.allowedTCPPorts = [ 25565 ports.minecraft-wildcat ];


    # tmux -S /run/minecraft/servername.sock attach, press Ctrl + b then d to detach.

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      dataDir = "/zfs2/servers/minecrafts";

      servers.wildcat-gamer-haven = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_21_4;
        jvmOpts = "-Xmx8192M -Xms4096M";

        serverProperties = {
          motd = "Wildcat Gamer Haven";
          white-list = false;
          difficulty = 2;
          gamemode = 0;
          max-players = 25;
          allow-flight = true;
          server-port = ports.minecraft-wildcat;
          spawn-protection = 0;
          pvp = false;
          view-distance = 32;
        };

        whitelist = {
          klaymor = "23ca81b5-5e74-47cd-93f9-766b2c721b4e";
          FAIRFAX100 = "7c3ad143-be71-4a89-a6c7-5de1f241df85";
          Pink_Laser_Beam = "01f9ed0a-c79d-4815-bbf2-1a94d2d70e43";
          troysh = "90eb6c3d-1055-4ae0-b5b0-c6b4cfb2429b"; # Eli
          djurilol = "078d6fe6-8901-4fa8-bb25-344535b281ca";
          eli_shmeli = "8f6ee452-f933-48a6-8e7b-294013d1876b";
          PifflePoffle = "07a50b00-cde9-431e-a909-ccff7e21ed57"; # Brad
          Denpants = "0a0e0766-bc44-498c-b039-49979d4a5507";
          StSwerve = "62b2d2f5-1c8a-4b53-abf2-798239dc4633"; # Marco
        };

        symlinks = {
          # "mods/Architectury.jar" = pkgs.fetchurl { # breaks server?
          #  url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/73nlw3WM/architectury-15.0.3-fabric.jar";
          #  sha512 = "6acc7cfccfc6e93fd8c1895fb2c489cbabd27265f38f7cbad98ddaab2cb2e6d1601633bd12cf26fc0bb100a87949ee06b872f333cf7b8490cccc0082ac586dcb";
          # };
          "mods/Distant Horizons.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uCdwusMi/versions/DTFSZmMF/DistantHorizons-neoforge-fabric-2.3.0-b-1.21.4.jar";
            sha512 = "7337d486cde3dd43f5bed5f81277170d0dab4257f5d355e1dc88d5cfb5577a8592a35a3df80d35e1ec81b799ebc7b398c348cec6e73a0d37e7952883e49d06dd";
          }; 
          "mods/Lithium.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/HtiXknlD/lithium-fabric-0.15.0%2Bmc1.21.4.jar";
            sha512 = "273c7c670638795a343634857f7440db8ce0f55a0f14f292cf17cf5d6a19a9ddcd170f7c95a1310a09b3ac52cde199e420023ab96ea7e5a6d6842f5680b9d598";
          };
          "mods/FerriteCore.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar";
            sha512 = "f41dc9e8b28327a1e29b14667cb42ae5e7e17bcfa4495260f6f851a80d4b08d98a30d5c52b110007ee325f02dac7431e3fad4560c6840af0bf347afad48c5aac";
          };
          "mods/Noisium.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar";
            sha512 = "3119f9325a9ce13d851d4f6eddabade382222c80296266506a155f8e12f32a195a00a75c40a8d062e4439f5a7ef66f3af9a46f9f3b3cb799f3b66b73ca2edee8";
          };
          "mods/C2ME.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/VSNURh3q/versions/gz43iXry/c2me-fabric-mc1.21.4-0.3.1.2%2Brc.1.0.jar";
            sha512 = "fa607e7fc1b2e649dccc85cc27fb9e5835e030c4b5dcfad0fbb0daf3beed9759165e762690cb91df0134b8dfbd05381a5031b9536a6901ab8745f2102acf2719";
          };
          # "mods/InventorySorter.jar" = pkgs.fetchurl { # breaks server?
          #   url = "https://cdn.modrinth.com/data/5ibSyLAz/versions/yHk2rvgW/InventorySorter-1.9.1-1.21.4.jar";
          #   sha512 = "ddeb0fba5082a7ff471baf9a1e339dba4648b6458ea8e0f9784984f836f4d69cb274536babaed385950c14e36b421b261484403b7aabbb7040ab38f79d1eac30";
          # };
          # "mods/Sort It Out.jar" = pkgs.fetchurl {
          #   url = "https://cdn.modrinth.com/data/jcOSOvm1/versions/4WXPHQGE/sort_it_out-fabric-1.1.0%2B1.21.4.jar";
          #   sha512 = "9510cc7f994b3a1c3bff0b16485aef99063df0e20bdbf0d25978cd774bf6414cab80e0a471771ae59a718a1dc4ce5f1b8339a3b031e915ac64679a7041ddfe07";
          # };
          # "mods/JamLib.jar" = pkgs.fetchurl {
          #   url = "https://cdn.modrinth.com/data/IYY9Siz8/versions/BGbqWe62/jamlib-fabric-1.3.2%2B1.21.4.jar";
          #   sha512 = "6b5f8dc80891b87fce819866d4dd65cd223b5ac87aa7225625b751b35e87962e9408fe5af159d3175f5016dab008b8be29df3fe2e6d46db7f7917ca47275afaa";
          # };
          # "mods/Jade.jar" = pkgs.fetchurl { # breaks server?
          #   url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/sSHUBFoq/Jade-1.21.4-Fabric-17.2.2.jar";
          #   sha512 = "dbe2ce335170c7a7079595c6341188ef07f54704faab7e3919a7c24130d3b25f321425c5f28107ea706f8d7e47e1d49147882ab05c35cbe6af7ac9d371ca68e7";
          # };

          # "world/datapacks/clock-ncompasses.zip" = pkgs.fetchurl {
          #   url = "https://s3.amazonaws.com/static.planetminecraft.com/files/resource_media/datapack/clock-ncompasses.zip?response-content-disposition=attachment%3B%20filename%3Dclock-ncompasses.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJ5VRI6NCTKXXUSGQ%2F20250409%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250409T042456Z&X-Amz-SignedHeaders=host&X-Amz-Expires=23400&X-Amz-Signature=12dcc19eeb70f651739e42a8b6d80ab5415fa21e18fb1634e5b2c9711146b44a";
          #   sha512 = "22561dacd511ee61bd030f896b0ff41e741ee7d76ae5d80a3ae55296616abd169ffbb7f185bb33228999e4cc65d0d8c9d4c40bd0385e3f0ba2e4ad63bbff86da";
          # };
          # "world/datapacks/Coordinates.zip" = pkgs.fetchurl {
          #   url = "https://cdn.modrinth.com/data/whyJQNpt/versions/XIyZceI5/Coordinates.zip";
          #   sha512 = "0b8175519c4f90f2c90b69596d690f86b5dbd2afe812a3d2405bea3cde75eb214ce378f45ac2d865032d6990006d2432c8ae0905e8e3689af31a361ceafdadc9";
          # };
        };
        # files = {
        #   "world/datapacks/Better_Compass.zip" = pkgs.fetchurl {
        #     url = "https://cdn.modrinth.com/data/JG6g520a/versions/nEwWlM42/PK_Better_Compass_V.3.0.0_MC_1.21.zip";
        #     sha512 = "302b0379c2544881a10f3e546315b7b5895c3653816c576a9b63fa745ffda80819220105d65546283334b96934c080fa7e16ad009341b7e61f5604b6db802e63";
        #   };
        # };
      };

      servers.frenched = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_4;
        jvmOpts = "-Xmx8192M -Xms4096M";

        serverProperties = {
          motd = "oui oui baguette";
          white-list = false;
          difficulty = 2;
          gamemode = 0;
          max-players = 25;
          allow-flight = true;
          server-port = ports.minecraft-frenched;
          spawn-protection = 0;
          view-distance = 32;
        };

        whitelist = {
          klaymor = "23ca81b5-5e74-47cd-93f9-766b2c721b4e";
          FAIRFAX100 = "7c3ad143-be71-4a89-a6c7-5de1f241df85";
          Pink_Laser_Beam = "01f9ed0a-c79d-4815-bbf2-1a94d2d70e43";
          troysh = "90eb6c3d-1055-4ae0-b5b0-c6b4cfb2429b"; # Eli
          djurilol = "078d6fe6-8901-4fa8-bb25-344535b281ca";
          eli_shmeli = "8f6ee452-f933-48a6-8e7b-294013d1876b";
          PifflePoffle = "07a50b00-cde9-431e-a909-ccff7e21ed57"; # Brad
          Denpants = "0a0e0766-bc44-498c-b039-49979d4a5507";
          StSwerve = "62b2d2f5-1c8a-4b53-abf2-798239dc4633"; # Marco
        };

        symlinks = {
          # "mods/Architectury.jar" = pkgs.fetchurl { # breaks server?
          #  url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/73nlw3WM/architectury-15.0.3-fabric.jar";
          #  sha512 = "6acc7cfccfc6e93fd8c1895fb2c489cbabd27265f38f7cbad98ddaab2cb2e6d1601633bd12cf26fc0bb100a87949ee06b872f333cf7b8490cccc0082ac586dcb";
          # };
          "mods/Distant Horizons.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uCdwusMi/versions/DTFSZmMF/DistantHorizons-neoforge-fabric-2.3.0-b-1.21.4.jar";
            sha512 = "7337d486cde3dd43f5bed5f81277170d0dab4257f5d355e1dc88d5cfb5577a8592a35a3df80d35e1ec81b799ebc7b398c348cec6e73a0d37e7952883e49d06dd";
          }; 
          "mods/Lithium.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/HtiXknlD/lithium-fabric-0.15.0%2Bmc1.21.4.jar";
            sha512 = "273c7c670638795a343634857f7440db8ce0f55a0f14f292cf17cf5d6a19a9ddcd170f7c95a1310a09b3ac52cde199e420023ab96ea7e5a6d6842f5680b9d598";
          };
          "mods/FerriteCore.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar";
            sha512 = "f41dc9e8b28327a1e29b14667cb42ae5e7e17bcfa4495260f6f851a80d4b08d98a30d5c52b110007ee325f02dac7431e3fad4560c6840af0bf347afad48c5aac";
          };
          "mods/Noisium.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar";
            sha512 = "3119f9325a9ce13d851d4f6eddabade382222c80296266506a155f8e12f32a195a00a75c40a8d062e4439f5a7ef66f3af9a46f9f3b3cb799f3b66b73ca2edee8";
          };
          "mods/C2ME.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/VSNURh3q/versions/gz43iXry/c2me-fabric-mc1.21.4-0.3.1.2%2Brc.1.0.jar";
            sha512 = "fa607e7fc1b2e649dccc85cc27fb9e5835e030c4b5dcfad0fbb0daf3beed9759165e762690cb91df0134b8dfbd05381a5031b9536a6901ab8745f2102acf2719";
          };
          # "mods/InventorySorter.jar" = pkgs.fetchurl { # breaks server?
          #   url = "https://cdn.modrinth.com/data/5ibSyLAz/versions/yHk2rvgW/InventorySorter-1.9.1-1.21.4.jar";
          #   sha512 = "ddeb0fba5082a7ff471baf9a1e339dba4648b6458ea8e0f9784984f836f4d69cb274536babaed385950c14e36b421b261484403b7aabbb7040ab38f79d1eac30";
          # };
          # "mods/Sort It Out.jar" = pkgs.fetchurl {
          #   url = "https://cdn.modrinth.com/data/jcOSOvm1/versions/4WXPHQGE/sort_it_out-fabric-1.1.0%2B1.21.4.jar";
          #   sha512 = "9510cc7f994b3a1c3bff0b16485aef99063df0e20bdbf0d25978cd774bf6414cab80e0a471771ae59a718a1dc4ce5f1b8339a3b031e915ac64679a7041ddfe07";
          # };
          # "mods/JamLib.jar" = pkgs.fetchurl {
          #   url = "https://cdn.modrinth.com/data/IYY9Siz8/versions/BGbqWe62/jamlib-fabric-1.3.2%2B1.21.4.jar";
          #   sha512 = "6b5f8dc80891b87fce819866d4dd65cd223b5ac87aa7225625b751b35e87962e9408fe5af159d3175f5016dab008b8be29df3fe2e6d46db7f7917ca47275afaa";
          # };
          # "mods/Jade.jar" = pkgs.fetchurl { # breaks server?
          #   url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/sSHUBFoq/Jade-1.21.4-Fabric-17.2.2.jar";
          #   sha512 = "dbe2ce335170c7a7079595c6341188ef07f54704faab7e3919a7c24130d3b25f321425c5f28107ea706f8d7e47e1d49147882ab05c35cbe6af7ac9d371ca68e7";
          # };

          # "world/datapacks/clock-ncompasses.zip" = pkgs.fetchurl {
          #   url = "https://s3.amazonaws.com/static.planetminecraft.com/files/resource_media/datapack/clock-ncompasses.zip?response-content-disposition=attachment%3B%20filename%3Dclock-ncompasses.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJ5VRI6NCTKXXUSGQ%2F20250409%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250409T042456Z&X-Amz-SignedHeaders=host&X-Amz-Expires=23400&X-Amz-Signature=12dcc19eeb70f651739e42a8b6d80ab5415fa21e18fb1634e5b2c9711146b44a";
          #   sha512 = "22561dacd511ee61bd030f896b0ff41e741ee7d76ae5d80a3ae55296616abd169ffbb7f185bb33228999e4cc65d0d8c9d4c40bd0385e3f0ba2e4ad63bbff86da";
          # };


        };
      };
    };

  };
}