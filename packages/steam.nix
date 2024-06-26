{ systemSettings, ... }:

{

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
  };


  home-manager.users.klaymore.xdg.desktopEntries.steam = {
    name = "Steam";
    comment = "Application for managing and playing games on Steam (scaled)";
    exec = "steam -forcedesktopscaling ${systemSettings.scaling} %U";
    terminal = false;
    categories = [ "Application" ];
    mimeType = [ ];
  };


}
