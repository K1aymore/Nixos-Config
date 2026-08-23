{ config, lib, pkgs, ... }:

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
