{ ... }:

{
  imports = [
    ./base.nix
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    ./system/pipewire.nix
    ./de/plasma.nix
    ./de/sway.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix

    ./system/opentablet.nix
    #./system/touchegg.nix

    ./system/syncthing.nix

    ./syncthing/sync.nix
    ./syncthing/media.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix


    ./impermanence/system.nix
    ./impermanence/home.nix
    #./home/home.nix
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?




  #services.getty.autologinUser = "klaymore";

  networking = {
    hostName = "oldlaptop";
    hostId = "e86a53d5"; # head -c 8 /etc/machine-id
    #interfaces.wlp2s0.useDHCP = true;
  };

  #services.xserver.displayManager.startx.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 0;  # dummy value
      STOP_CHARGE_THRESH_BAT0 = 1; # charge to 60%

      RESTORE_THRESHOLDS_ON_BAT = 1; # reset max charge after unplugging charger

      /* CPU_SCALING_GOVERNOR_ON_AC = "performance"; */
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      /* CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance"; */
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  services.fprintd.enable = true;


  services.blueman.enable = false; # Plasma comes with a Bluetooth daemon


}
