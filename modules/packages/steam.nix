{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {
    environment.variables = {
      STEAM_FORCE_DESKTOPUI_SCALING = config.klaymore.gui.scaling;
    };

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      extest.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

  };
}