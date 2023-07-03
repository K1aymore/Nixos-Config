{ pkgs, ... }:

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
    #./packages/VMs.nix
    #./packages/deep3D-depends.nix

    #./system/opentablet.nix

    #./system/ipfs.nix
    #./pc/syncplay.nix
    #./pc/i2p.nix
    ./system/zfs.nix


    ./system/syncthing.nix

    ./syncthing/sync.nix
    ./syncthing/media.nix
    ./syncthing/archive.nix
    ./syncthing/dotfiles.nix
    ./syncthing/ellidaProjects.nix
    ./syncthing/ellidaSync.nix
    ./syncthing/nixcfg.nix
    ./syncthing/projects.nix


    ./impermanence/system.nix
    ./impermanence/home.nix
  ];

  #boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  #boot.zfs.enableUnstable = true;
  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
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

  /* environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_5_15.amdgpu-pro
  ]; */



  nixpkgs.overlays = [
    (final: prev: {
      qbittorrent = prev.qbittorrent.overrideAttrs (old: {
        version = "4.6.0beta1";
        src = prev.fetchFromGitHub {
          owner = "qbittorrent";
          repo = "qbittorrent";
          rev = "2bbfd317cef6f5d9d81fa2af55ca9b77612acef4";
          hash = "sha256-Li9OCx2PQUedotiKUNIem22M8W6IQ6Uqg9zuNLakG0s=";
        };
      });
    })
  ];




  networking = {
    hostName = "pc";
    hostId = "7c980de5"; # head -c 8 /etc/machine-id
    firewall = {
      allowedTCPPorts = [ 57701 ];
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
    /* "Huge Archive" = {
      path = "/synced/HugeArchive";
      devices = [ "server" ];
      ignorePerms = false;
    }; */
  };





}
