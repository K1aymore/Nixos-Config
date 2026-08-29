{ config, lib, pkgs, settings, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {

    environment.systemPackages = with pkgs; [
      wineWow64Packages.full
      umu-launcher
      dxvk
      # lutris
      #playonlinux
      # bottles
      #grapejuice
      protonup-qt
      #protontricks
      #openal
      heroic
      #legendary-gl
      winetricks
      protontricks


      r2modman

      #piper
      # razergenie

      #minecraft
      #itch
      prismlauncher
      jdk25
      jdk17
      jdk8
    ];

    environment.sessionVariables = {
      #   STEAM_FORCE_DESKTOPUI_SCALING = config.klaymore.gui.scaling;
    };

    nixpkgs.overlays = [
      (final: prev: {
        proton-ge-bin = prev.proton-ge-bin.overrideAttrs (old: rec {
          version = "GE-Proton11-6";
          src =
            if settings.architecture == "x86_64-linux"
            then pkgs.fetchzip {
              url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}-x86_64.tar.gz";
              hash = "sha256-rX27DUrrrHtR1cgyr/424m9JPjrdASIisVGv2vWzMAs=";
            }
            else pkgs.fetchzip {
              url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}-aarch64.tar.gz";
              hash = "";
            };
        });
      })
    ];

    hardware.steam-hardware.enable = true;

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
        extraEnv = {
          # LD_PRELOAD="" MANGOHUD=1 GAMEMODERUN=1 PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1 %command%
          LD_PRELOAD = "";
          MANGOHUD = "1";
          GAMEMODERUN = "1";
          PROTON_ENABLE_WAYLAND = "1";
          PROTON_ENABLE_HDR = "1";
          # PROTON_FSR4_RDNA3_UPGRADE = "1";
        };
      };
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true;
      # extest.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    programs.gamescope.enable = true;


    home-manager.users.klaymore.programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        fps_limit = [ 0 150 60 ]; # doesn't work with mangoapp
        show_fps_limit = true;

        arch = true;
        vulkan_driver = true;
        wine = true;
        gamemode = true;
        vkbasalt = true;
        wsync = true;
        resolution = true;

        cpu_temp = true;
        gpu_temp = true;
        #gpu_fan = true;
        gpu_core_clock = true;
        gpu_mem_clock = true;
        #gpu_voltage = true;

        ram = true;
        vram = true;
        io_read = true;
        io_write = true;
      };
    };

    programs.gamemode.enable = true;
    programs.gamemode.settings = {
      general = {
        renice = 10;
        desiredgov = "performance";
        desiredprof = "performance";
      };
    };

  };
}
