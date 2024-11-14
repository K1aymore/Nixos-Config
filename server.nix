{ ... }:


{

  imports = [
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    
    #./de/plasma6.nix
    
    ./packages/gui.nix


    ./services/system/zfs.nix
    ./services/system/zram.nix


    ./services/server/ssh.nix
    ./services/server/wireguard-forwarding.nix

    ./services/server/nginx.nix
    ./services/server/synapse.nix
    ./services/server/gitea.nix
    ./services/server/nfs.nix
    #./services/server/syncplay.nix
    ./services/server/tt-rss.nix
    #./server/minecraft.nix
    # ./server/restyaboard.nix
    # ./server/radicale.nix


    #./syncthing

    ./syncthing/archive.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/ellidaSync.nix
    ./syncthing/media.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix
    ./syncthing/sync.nix


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




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?


}
