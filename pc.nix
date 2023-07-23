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
      mesa = prev.mesa.overrideAttrs (old: {
        version = "git";
        src = mesa-git;
        mesonFlags = [
          "--sysconfdir=/etc"
          "--datadir=${placeholder "drivers"}/share" # Vendor files

          # Don't build in debug mode
          # https://gitlab.freedesktop.org/mesa/mesa/blob/master/docs/meson.html#L327
          "-Db_ndebug=true"

          "-Ddisk-cache-key=${placeholder "drivers"}"
          "-Ddri-search-path=${libglvnd.driverLink}/lib/dri"

          "-Dplatforms=${lib.concatStringsSep "," ([ "x11" ] ++ lib.optionals stdenv.isLinux [ "wayland" ])}"
          "-Dgallium-drivers=${lib.concatStringsSep "," (if stdenv.isLinux then
            [
              "d3d12" # WSL emulated GPU (aka Dozen)
              "nouveau" # Nvidia
              "radeonsi" # new AMD (GCN+)
              "r300" # very old AMD
              "r600" # less old AMD
              "swrast" # software renderer (aka LLVMPipe)
              "svga" # VMWare virtualized GPU
              "virgl" # QEMU virtualized GPU (aka VirGL)
              "zink" # generic OpenGL over Vulkan, experimental
            ] ++ lib.optionals (stdenv.isAarch64 || stdenv.isAarch32) [
              "etnaviv" # Vivante GPU designs (mostly NXP/Marvell SoCs)
              "freedreno" # Qualcomm Adreno (all Qualcomm SoCs)
              "lima" # ARM Mali 4xx
              "panfrost" # ARM Mali Midgard and up (T/G series)
              "vc4" # Broadcom VC4 (Raspberry Pi 0-3)
            ] ++ lib.optionals stdenv.isAarch64 [
              "tegra" # Nvidia Tegra SoCs
              "v3d" # Broadcom VC5 (Raspberry Pi 4)
            ] ++ lib.optionals stdenv.hostPlatform.isx86 [
              "iris" # new Intel, could work on non-x86 with PCIe cards, but doesn't build as of 22.3.4
              "crocus" # Intel legacy, x86 only
              "i915" # Intel extra legacy, x86 only
            ]
          else [ "auto" ])}"
          "-Dvulkan-drivers=auto,amd"

          "-Ddri-drivers-path=${placeholder "drivers"}/lib/dri"
          "-Dvdpau-libs-path=${placeholder "drivers"}/lib/vdpau"
          "-Domx-libs-path=${placeholder "drivers"}/lib/bellagio"
          "-Dva-libs-path=${placeholder "drivers"}/lib/dri"
          "-Dd3d-drivers-path=${placeholder "drivers"}/lib/d3d"

          "-Dgallium-nine=${lib.boolToString stdenv.isLinux}" # Direct3D in Wine
          "-Dosmesa=${lib.boolToString stdenv.isLinux}" # used by wine
          "-Dmicrosoft-clc=disabled" # Only relevant on Windows (OpenCL 1.2 API on top of D3D12)

          # To enable non-mesa gbm backends to be found (e.g. Nvidia)
          "-Dgbm-backends-path=${libglvnd.driverLink}/lib/gbm:${placeholder "out"}/lib/gbm"

          # meson auto_features enables these features, but we do not want them
          "-Dandroid-libbacktrace=disabled"

        ] ++ lib.optionals stdenv.isLinux [
          "-Dglvnd=true"

          # Enable RT for Intel hardware
          "-Dintel-clc=enabled"
        ] ++ lib.optionals (stdenv.isLinux && stdenv.isx86_64) [
          # Clover, old OpenCL frontend
          "-Dgallium-opencl=icd"
          "-Dopencl-spirv=true"

          # Rusticl, new OpenCL frontend
          "-Dgallium-rusticl=true"
          "-Drust_std=2021"
          "-Dclang-libdir=${prev.mesa.llvmPackages.clang-unwrapped.lib}/lib"
        ] ++ lib.optionals (!lib.meta.availableOn stdenv.hostPlatform valgrind-light && !valgrind-light.meta.broken) [
          "-Dvalgrind=disabled"
        ] ++ lib.optional true
          "-Dvideo-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec";
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
