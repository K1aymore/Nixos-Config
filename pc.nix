{ pkgs, ... }:

{

  klaymore = {
    powerful = true;
    localIP = "172.16.0.123";

    system = {
      impermanence.system.enable = true;
      keyboard = ""; # only affects tty
      zram.enable = true;
    };

    gui = {
      enable = true;
      hdr = true;
      scaling = "1.75";
      plasma.enable = true;
    };
    pipewire.enable = true;

    programs = {
    };

    services = {
      mullvad.enable = true;
      syncthing.enable = true;
    };
  };

  # specialisation.niri.configuration = {
  #   myOptions.plasma.enable = lib.mkForce false;
  #   myOptions.niri.enable = true;
  # };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     krita = prev.krita.overrideAttrs (old: {
  #       version = "hdr";
  #       src = builtins.fetchurl {
  #         url = "https://invent.kde.org/dkazakov/krita/-/archive/kazakov/wayland-color-management/krita-kazakov-wayland-color-management.tar.gz";
  #         sha256 = "1ggsnhnkbf6z7m1m8cwddxyqr0xfnwrr1i476iq707yzkkpskcia";
  #       };
  #     });
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    #godot_git
    #opentoonz
    briar-desktop
  ];


  # https://rbf.dev/blog/2020/05/custom-nixos-build-for-raspberry-pis/#building-on-nixos-using-nixos-generators
  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];



  boot.kernelPackages = pkgs.linuxPackages_zen;

  #boot.initrd.kernelModules = [ "amdgpu" ];
  # https://discourse.nixos.org/t/amd-gpu-optimal-settings/27648/2
  #services.xserver.videoDrivers = [ "amdgpu" ];

  
  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];


  #programs.adb.enable = true;


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      libva
      libva-utils
      #libvdpau-va-gl
      #vaapiVdpau
      vdpauinfo

      # AMDVLK seems to break MPV
      #amdvlk
    ];
    extraPackages32 = with pkgs; [
      #driversi686Linux.amdvlk
    ];
  };

  #programs.corectrl.enable = true;

  #environment.variables.AMD_VULKAN_ICD = "RADV";


  networking = {
    hostId = "7c980de5"; # head -c 8 /etc/machine-id
  };


  /* services.boinc = {
    enable = true;
    dataDir = "/nix/persist/appdata/BOINC";
    };
  users.users.boinc.extraGroups = [ "video" ]; */



  # Star Citizen
  #networking.extraHosts = "127.0.0.1 modules-cdn.eac-prod.on.epicgames.com";
  # boot.kernel.sysctl = {
  #   "vm.max_map_count" = 16777216;
  #   "fs.file-max" = 524288;
  # };


}
