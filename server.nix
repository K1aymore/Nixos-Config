{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/colemak.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/sway.nix

      ./packages/gui.nix

      ./server/ssh.nix

      ./server/nginx.nix
      ./server/synapse.nix
      ./server/minecraft.nix
      # ./server/restyaboard.nix
      # ./server/radicale.nix


      # ./system/opentablet.nix

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];



  networking = {
    hostName = "server";
    hostId = "03828261";
    domain = "klaymore.me";
  };


  security.acme.email = "klaymorer@protonmail.com";
  security.acme.acceptTerms = true;


  /* services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily sudo rclone sync /nix/persist /synced/Archive/NixPersist && sudo chown -R klaymore:users /synced/Archive/NixPersist"
    ];
  }; */


  services.syncthing.folders = {
      "Sync" = {
        path = "/synced/Sync";
        devices = [ "pc" "portable" "laptop" "pinephone" "pixel" ];
        ignorePerms = false;
      };
      "Dotfiles" = {
        path = "/nix/dotfiles";
        devices = [ "pc" "portable" "laptop" ];
        ignorePerms = false;
      };
      "NixCfg" = {
        path = "/nix/cfg";
        devices = [ "pc" "portable" "laptop" "pinephone" "pixel" ];
        ignorePerms = false;
      };
      "Projects" = {
        path = "/synced/Projects";
        devices = [ "pc" "portable" "laptop" ];
        ignorePerms = false;
      };
      "Archive" = {
        path = "/synced/Archive";
        devices = [ "pc" "laptop" "portable" ];
        ignorePerms = false;
      };
      /*"Huge Archive" = {
        path = "/synced/Huge Archive";
        devices = [ "pc" ];
        ignorePerms = false;
      };*/
      "Ellida Sync" = {
        path = "/synced/Ellida Sync";
        devices = [ "pc" "portable" "cDesk" ];
        ignorePerms = false;
      };
      "Ellida Projects" = {
        path = "/synced/Ellida Projects";
        devices = [ "pc" "portable" "laptop" "cDesk" ];
        ignorePerms = true;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "pc" "portable" "laptop" "pinephone" "pixel" ];
        ignorePerms = false;
        rescanInterval = 30;
      };
  };





}
