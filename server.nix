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
    #./services/server/syncplay.nix
    #./server/tt-rss.nix
    #./server/minecraft.nix
    # ./server/restyaboard.nix
    # ./server/radicale.nix

    ./syncthing

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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?



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
