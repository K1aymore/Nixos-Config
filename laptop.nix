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
    #./packages/games.nix
    ./packages/coding.nix

    #./packages/zerotier.nix
    #./system/opentablet.nix
    #./system/touchegg.nix

    ./system/syncthing.nix

    ./syncthing/sync.nix
    ./syncthing/media.nix
    ./syncthing/archive.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix


    ./impermanence/system.nix
    ./impermanence/home.nix
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
  system.stateVersion = "21.11"; # Did you read the comment?
  
  
  
  #services.getty.autologinUser = "klaymore";

  networking = {
    hostName = "laptop";
    hostId = "57d90d30"; # head -c 8 /etc/machine-id
    #interfaces.wlp2s0.useDHCP = true;

    firewall.allowedTCPPorts = [ 5201 ];
  };

  #boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  services.power-profiles-daemon.enable = true;
  services.tlp = {
    enable = false;
    settings = {
      #START_CHARGE_THRESH_BAT1 = 0;  # dummy value
      #STOP_CHARGE_THRESH_BAT1 = 65; # charge to 65%

      #RESTORE_THRESHOLDS_ON_BAT = 1; # reset max charge after unplugging charger

      #CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      #CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    };
  };

  services.fprintd.enable = true;


  services.blueman.enable = false; # Plasma comes with a Bluetooth daemon

  services.flatpak.enable = true;


}
