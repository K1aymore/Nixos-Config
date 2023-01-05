{ config, pkgs, ... }:

{

  imports = [
    ./base.nix
    ./locale/colemak.nix
    ./locale/losAngeles.nix
    ./system/pipewire.nix
    #./de/plasma.nix
    ./de/sway.nix

    ./packages/gui.nix
#   ./packages/games.nix
    ./packages/coding.nix

    #./system/opentablet.nix
    #./system/touchegg.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
    #./home/home.nix
  ];


  #services.getty.autologinUser = "klaymore";

  networking = {
    hostName = "thinkpad";
    hostId = "e86a53d6";  # head -c 8 /etc/machine-id
    #interfaces.wlp2s0.useDHCP = true;
  };

  #services.xserver.displayManager.startx.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
      settings = {
        START_CHARGE_THRESH_BAT1 = 0;  # dummy value
        STOP_CHARGE_THRESH_BAT1 = 65; # charge to 65%

        RESTORE_THRESHOLDS_ON_BAT = 1; # reset max charge after unplugging charger

        #CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        #CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
     };
  };

  services.fprintd.enable = true;


  services.blueman.enable = false; # Plasma comes with a Bluetooth daemon


  services.syncthing.folders = {
#     "Archive" = {
#       path = "/synced/Archive";
#       devices = [ "server" "pc" "portable" ];
#       ignorePerms = false;
#     };
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Media" = {
      path = "/synced/Media";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/synced/Nix/dotfiles";
      devices = [ "server" "pc" "portable" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/synced/Nix/cfg";
      devices = [ "server" "pc" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "server" "pc" "portable" "winpc" ];
      ignorePerms = false;
    };
    /* "Ellida Sync" = {
      path = "/synced/Ellida Sync";
      devices = [ "server" "pc" "portable" "cDesk" ];
      ignorePerms = false;
    }; */
#     "Ellida Projects" = {
#       path = "/synced/Ellida Projects";
#       devices = [ "server" "pc" "portable" "cDesk" ];
#       ignorePerms = true;
#     };
  };




}
