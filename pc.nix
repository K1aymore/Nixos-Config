{ pkgs, lib, nixpkgs, mesa-git, ... }:

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


    #./packages/zerotier.nix
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



  nixpkgs.overlays = with import nixpkgs { system = "x86_64-linux"; }; [
    (final: prev: {
      mesa = (prev.mesa.override {
        vulkanDrivers =
          if stdenv.isLinux then
            [
              "amd" # AMD (aka RADV)
              "microsoft-experimental" # WSL virtualized GPU (aka DZN/Dozen)
              "swrast" # software renderer (aka Lavapipe)
            ]
            ++ lib.optionals (stdenv.hostPlatform.isAarch -> lib.versionAtLeast stdenv.hostPlatform.parsed.cpu.version "6") [
              # QEMU virtualized GPU (aka VirGL)
              # Requires ATOMIC_INT_LOCK_FREE == 2.
              "virtio"
            ]
            ++ lib.optionals stdenv.isAarch64 [
              "broadcom" # Broadcom VC5 (Raspberry Pi 4, aka V3D)
              "freedreno" # Qualcomm Adreno (all Qualcomm SoCs)
              "imagination-experimental" # PowerVR Rogue (currently N/A)
              "panfrost" # ARM Mali Midgard and up (T/G series)
            ]
            ++ lib.optionals stdenv.hostPlatform.isx86 [
              "intel" # Intel (aka ANV), could work on non-x86 with PCIe cards, but doesn't build
              "intel_hasvk" # Intel Haswell/Broadwell, "legacy" Vulkan driver (https://www.phoronix.com/news/Intel-HasVK-Drop-Dead-Code)
            ]
          else [ "auto" ];
      }).overrideAttrs (old: {
        version = "git";
        src = mesa-git;
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


  #services.syncthing.relay.enable = true;
  #services.syncthing.relay.port = 61456;
  #services.syncthing.folders = {
  /* "Huge Archive" = {
      path = "/synced/HugeArchive";
      devices = [ "server" ];
      ignorePerms = false;
    }; */
  #};





}
