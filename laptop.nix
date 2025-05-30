{ ... }:

{

  imports = [
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    
    ./de
    #./de/hyprland.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix
    ./packages/steam.nix

    #./system/opentablet.nix


    ./system/syncthing.nix
    ./system/zram.nix

    #./impermanence/system.nix
#   #./impermanence/home.nix
  ];

  myOptions.plasma.enable = true;
  
  #services.getty.autologinUser = "klaymore";

  networking = {
    hostId = "57d90d30"; # head -c 8 /etc/machine-id
    #interfaces.wlp2s0.useDHCP = true;

    firewall.allowedTCPPorts = [ 5201 ];
  };

  #boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  # occasionally powers off if not on performance setting
  #services.power-profiles-daemon.enable = true;
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




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
