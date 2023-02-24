{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/colemak.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix

      #./packages/gui.nix

      ./server/ssh.nix
      #./server/nfs.nix

      ./server/nginx.nix
      ./server/synapse.nix
      ./server/gitea.nix
      #./server/minecraft.nix
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



  /* services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily sudo rclone sync /nix/persist /synced/Archive/NixPersist && sudo chown -R klaymore:users /synced/Archive/NixPersist"
    ];
  }; */


  services.syncthing.folders = {
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "pc" "portable" "laptop" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Media" = {
      path = "/synced/Media";
      devices = [ "pc" "laptop" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/nix/dotfiles";
      devices = [ "pc" "portable" "laptop" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/nix/cfg";
      devices = [ "pc" "portable" "laptop" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "pc" "portable" "laptop" "pinephone" "winpc" ];
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
  };





}
