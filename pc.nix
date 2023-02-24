{ config, pkgs, lib, ... }:

{

  imports = [
    ./base.nix
    ./locale/qwerty.nix
    ./locale/losAngeles.nix
    ./system/pipewire.nix
    ./de/plasma.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix
    ./packages/video-editing.nix
    /* ./packages/blender-2-9.nix */

    ./system/opentablet.nix

    ./system/ipfs.nix
    ./pc/syncplay.nix
    ./system/zfs.nix

    ./impermanence/system.nix
    ./impermanence/home.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  #boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  #boot.zfs.enableUnstable = true;
  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      #rocm-opencl-icd
      #rocm-opencl-runtime
      #libva
      #libva-utils
      #libvdpau-va-gl
      #vaapiVdpau
      #amdvlk
    ];
    extraPackages32 = with pkgs; [
      #driversi686Linux.amdvlk
    ];
  };

  /* environment.variables.AMD_VULKAN_ICD = "RADV"; */

  hardware.steam-hardware.enable = true;
  #hardware.pulseaudio.support32Bit = true;

  services.gvfs.enable = true;

  /* environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_5_15.amdgpu-pro
  ]; */




  networking = {
    hostName = "pc";
    hostId = "7c980de5";  # head -c 8 /etc/machine-id
    firewall = {
      allowedTCPPorts = [ 54903 55054 58819 61456 ];
      allowedUDPPorts = [ 54903 55054 58819 61456 ];
    };
  };


  /* services.boinc = {
    enable = true;
    dataDir = "/nix/persist/appdata/BOINC";
  };
  users.users.boinc.extraGroups = [ "video" ]; */


  services.syncthing.relay.enable = true;
  services.syncthing.relay.port = 61456;
  services.syncthing.folders = {
    "Sync" = {
      path = "/synced/Sync";
      devices = [ "server" "laptop" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Media" = {
      path = "/synced/Media";
      devices = [ "server" "laptop" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Dotfiles" = {
      path = "/nix/dotfiles";
      devices = [ "server" "laptop" "portable" ];
      ignorePerms = false;
    };
    "NixCfg" = {
      path = "/nix/cfg";
      devices = [ "server" "laptop" "portable" "pinephone" "pixel" "winpc" ];
      ignorePerms = false;
    };
    "Projects" = {
      path = "/synced/Projects";
      devices = [ "server" "laptop" "portable" "pinephone" "winpc" ];
      ignorePerms = false;
    };
    "Archive" = {
      path = "/synced/Archive";
      devices = [ "server" "laptop" ];
      ignorePerms = false;
    };
    /* "Huge Archive" = {
      path = "/synced/HugeArchive";
      devices = [ "server" ];
      ignorePerms = false;
    }; */
    "Ellida Sync" = {
      path = "/synced/EllidaSync";
      devices = [ "server" "portable" "cDesk" ];
      ignorePerms = false;
    };
    "Ellida Projects" = {
      path = "/synced/EllidaProjects";
      devices = [ "server" "laptop" "portable" "cDesk" ];
      ignorePerms = true;
    };
    "MasterKitty" = {
      path = "/synced/Stuff/masterkitty";
      devices = [ "masterkitty" ];
    };
  };





}
