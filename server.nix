{ ... }:


{

  imports = [
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    ./de/plasma.nix

    ./packages/gui.nix

    #./server/ssh.nix
    #./services/server/nfs.nix

    ./services/system/zfs.nix

    ./services/system/zram.nix

    ./services/server/nginx.nix
    ./services/server/synapse.nix
    ./services/server/gitea.nix
    ./services/server/nfs.nix
    #./services/server/syncplay.nix
    ./services/server/tt-rss.nix
    #./server/minecraft.nix
    # ./server/restyaboard.nix
    # ./server/radicale.nix

    ./syncthing

    ./syncthing/archive.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/ellidaSync.nix
    ./syncthing/media.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix
    ./syncthing/sync.nix

    # ./system/opentablet.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  #boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only


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
