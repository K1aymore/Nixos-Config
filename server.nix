{ ... }:


{

  imports = [
    ./base.nix
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    ./system/pipewire.nix
    ./de/plasma.nix

    ./packages/gui.nix

    #./server/ssh.nix
    ./server/nfs.nix

    ./system/zfs.nix

    ./server/nginx.nix
    ./server/synapse.nix
    ./server/gitea.nix
    #./server/tt-rss.nix
    #./server/minecraft.nix
    # ./server/restyaboard.nix
    # ./server/radicale.nix

    ./system/syncthing.nix

    # ./system/opentablet.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];



  networking = {
    hostName = "server";
    hostId = "03828261";
    domain = "klaymore.me";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
networking.firewall.allowedUDPPorts = [ 25565 ];

  programs.java.enable = true;

  /* services.cron = {
    enable = true;
    systemCronJobs = [
      "@daily sudo rclone sync /nix/persist /synced/Archive/NixPersist && sudo chown -R klaymore:users /synced/Archive/NixPersist"
    ];
  }; */


  services.syncthing.settings.folders = {
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "pc" "portable" "laptop" "acer" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Media" = {
      path = "/synced/Media";
      devices = [ "pc" "laptop" "acer" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/synced/Nix/dotfiles";
      devices = [ "pc" "portable" "laptop" "acer" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/synced/Nix/cfg";
      devices = [ "pc" "portable" "laptop" "acer" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "pc" "portable" "laptop" "acer" "pinephone" "winpc" ];
      ignorePerms = false;
    };
    "Archive" = {
      path = "/synced/Archive";
      devices = [ "pc" "acer" "portable" ];
      ignorePerms = false;
    };
    /*"Huge Archive" = {
      path = "/synced/Huge Archive";
      devices = [ "pc" ];
      ignorePerms = false;
    };*/
    "Ellida Sync" = {
      path = "/synced/Ellida Sync";
      devices = [ "pc" "cDesk" ];
      ignorePerms = false;
    };
    "Ellida Projects" = {
      path = "/synced/Ellida Projects";
      devices = [ "pc" "portable" "laptop" "acer" "cDesk" ];
      ignorePerms = true;
    };
  };





}
