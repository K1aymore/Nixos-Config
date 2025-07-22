{ config, lib, ... }:

{

  options.klaymore = {
    configPath = lib.mkOption { default = "/synced/Nix/cfg"; };
    powerful = lib.mkOption { default = false; };
    publicIP = lib.mkOption { default = "71.231.122.199"; };
    localIP = lib.mkOption { default = ""; };
    serverLan = lib.mkOption { default = "172.16.0.115"; };


    gui = {
      enable = lib.mkEnableOption "GUI";
      hdr = lib.mkOption { default = false; };
      scaling = lib.mkOption { default = "1"; };
      wayland = lib.mkOption { default = config.klaymore.gui.enable; };
      plasma = {
        enable = lib.mkEnableOption "Plasma";
      };
    };
    pipewire = {
      enable = lib.mkOption { default = true; };
    };


    programs = {
      mpd = {
        enable = lib.mkOption { default = true; };
      };
      mpv = {
        enable = lib.mkOption { default = config.klaymore.gui.enable; };
      };
      vscode = {
        enable = lib.mkOption { default = config.klaymore.gui.enable; };
      };
    };


    servers = {
      forgejo.enable = lib.mkEnableOption "Forgejo";
      jellyfin.enable = lib.mkEnableOption "Jellyfin";
      minecraft = {
        enable = lib.mkEnableOption "Minecraft servers";
      };
      nfs.enable = lib.mkEnableOption "NFS support";
      nginx.enable = lib.mkEnableOption "NGINX";
    };


    services = {
      espanso.enable = lib.mkOption { default = config.klaymore.gui.enable; };
      ipfs.enable = lib.mkEnableOption "IPFS";
      mullvad.enable = lib.mkEnableOption "Mullvad";
      ssh = {
        listen.enable = lib.mkEnableOption "SSH listening server";
      };
      syncthing.enable = lib.mkOption { default = true; };
      wireguard-forwarding.enable = lib.mkEnableOption "wireguard-forwarding";
      yggdrasil = {
        enable = lib.mkEnableOption "Yggdrasil";
        peers = lib.mkOption { default = []; };
      };
    };


    system = {
      catppuccin.enable = lib.mkOption { default = true; };
      fish.enable = lib.mkOption { default = true; };
      impermanence.home.enable = lib.mkEnableOption "Home Impermanence";
      impermanence.system.enable = lib.mkEnableOption "System Impermanence";
      keyboard = lib.mkOption { default = "colemak"; };
      locale = lib.mkOption { default = "en_US.UTF-8"; };
      timeZone = lib.mkOption { default = "America/Los_Angeles"; };
      zfs.enable = lib.mkEnableOption "ZFS";
      zram.enable = lib.mkOption { default = true; };
    };

  };
}
