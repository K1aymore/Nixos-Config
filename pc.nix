{ pkgs, lib, ... }:

{

  imports = [
    ./locale/qwerty.nix
    ./locale/losAngeles.nix
    
    ./de/plasma.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix
    ./packages/video-editing.nix
    ./packages/mpd.nix

    #./packages/zerotier.nix
    #./packages/VMs.nix
    #./packages/deep3D-depends.nix

    ./services/system/opentablet.nix

    #./system/ipfs.nix
    #./pc/syncplay.nix
    #./pc/i2p.nix
    ./services/system/zfs.nix
    ./services/system/espanso.nix
    ./services/system/waydroid.nix
    ./services/system/zram.nix


    ./syncthing

    ./syncthing/sync.nix
    ./syncthing/media.nix
    ./syncthing/archive.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/ellidaSync.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix


    ./impermanence
  ];


  hardware.uinput.enable = true;


  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.zfs.extraPools = [ "stuff" ];
  
  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      libva
      libva-utils
      #libvdpau-va-gl
      #vaapiVdpau
      vdpauinfo
      #amdvlk
    ];
    extraPackages32 = with pkgs; [
      #driversi686Linux.amdvlk
    ];
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";

  #hardware.pulseaudio.support32Bit = true;

  services.gvfs.enable = true;



  networking = {
    hostName = "pc";
    hostId = "7c980de5"; # head -c 8 /etc/machine-id
    firewall = {
      allowedTCPPorts = [ 57701 ];
    };
    hosts = {
      #"127.0.0.1" = [ "youtube.com" "youtu.be" "www.youtube.com" ];
    };
    
  };


  /* services.boinc = {
    enable = true;
    dataDir = "/nix/persist/appdata/BOINC";
    };
  users.users.boinc.extraGroups = [ "video" ]; */



  # Star Citizen
  networking.extraHosts = "127.0.0.1 modules-cdn.eac-prod.on.epicgames.com";
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };
  
  
  
  

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
