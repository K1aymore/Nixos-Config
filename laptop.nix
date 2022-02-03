{ config, pkgs, ... }:

{

  imports = [
      ./base.nix
      ./locale/colemak.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix

      ./system/opentablet.nix
      #./home-manager/home-manager.nix

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];

  environment.variables = {
    XKB_DEFAULT_VARIANT = "colemak";
  };


  networking = {
    hostName = "laptop";
    #interfaces.wlp2s0.useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 22067 ];  # transfers & relay
      allowedUDPPorts = [ 21027 22067 ];  # discovery
    };
  };



  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    relay.enable = true;
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "RSARTXL-H57CHF3-JBVXMNT-0SUZQ7I-XW5BFWX-DWUNQE5-2ZXGZ3A-QQI0YQQ"; };
      "portable" = { id = "L5D2A3L-MEEXKHK-ZGL3YNN-2JFJSEA-LXSNJOO-DYTOFDH-WVEXAZB-675DZAL"; };
      "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      "cDesk" = { id = "RLFHUVQ-HXAGZ54-DGEN2S3-YRHRWID-D6Q4S4B-PNOCIDP-T2NNWZP-GPY5NQG"; };
    };
    folders = {
      "Sync" = {
        path = "/synced/Sync";
        devices = [ "server" "pc" "portable" "phone" ];
        ignorePerms = false;
      };
      "Dotfiles" = {
        path = "/nix/dotfiles";
        devices = [ "server" "pc" "portable" ];
        ignorePerms = false;
      };
      "NixCfg" = {
        path = "/nix/cfg";
        devices = [ "server" "pc" "portable" "phone" ];
        ignorePerms = false;
      };
      "Projects" = {
        path = "/synced/Projects";
        devices = [ "server" "pc" "portable" ];
        ignorePerms = false;
      };
      "Ellida Sync" = {
        path = "/synced/Ellida Sync";
        devices = [ "server" "pc" "portable" "cDesk" ];
        ignorePerms = false;
      };
      "Ellida Projects" = {
        path = "/synced/Ellida Projects";
        devices = [ "server" "pc" "portable" "cDesk" ];
        ignorePerms = true;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "server" "pc" "portable" "phone" ];
        ignorePerms = false;
        rescanInterval = 30;
      };
    };
  };




}
