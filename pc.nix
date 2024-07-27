{ pkgs, config, lib, ... }:

{

  imports = [
    ./locale/qwerty.nix
    ./locale/losAngeles.nix
    
    ./de/plasma6.nix
    ./de/hdr.nix
    #./de/cosmic.nix
    #./de/niri.nix
    #./de/wayfire.nix
    #./de/sway.nix
	  #./de/xfce.nix
	  #./de/hyprland.nix
	  #./de/gnome.nix

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix
    #./packages/video-editing.nix
    #./packages/mpd.nix
    
    ./packages/steam.nix

    #./packages/zerotier.nix
    #./packages/VMs.nix
    #./packages/deep3D-depends.nix
    

    ./services/system/opentablet.nix

    # ./services/system/ipfs.nix
    #./services/pc/i2p.nix
    
    ./services/system/zfs.nix
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


    #./impermanence/home.nix
    ./impermanence/system.nix
    #./impermanence/steam.nix
  ];

  
  /*specialisation.plasma5.configuration = {
    system.nixos.tags = [ "plasma5" ];
    services = {
      desktopManager.plasma6.enable = false;
      xserver.desktopManager.plasma5.enable = true;      
    };
  };*/


  nixpkgs.overlays = [
    # (final: prev: {
    #   godot_git = prev.godot_4.overrideAttrs (o: {
    #     version = "git";

    #     src = pkgs.fetchFromGitHub {
    #       owner = "godotengine";
    #       repo = "godot";
    #       rev = "1ce6df7087113a61491567f3ac55561d5688e2a8";
    #       hash = "sha256-sEpJHds0Tzzwbc8MmRKxt4Qf73BEAIqlh5c7K2X7IQw=";
    #     };
    #   });
      
    # })

    (final: prev: rec {
      python3 = prev.python3.override {
        packageOverrides = self: super: {
          wxpython =
            let
              waf_2_0_25 = pkgs.fetchurl {
                url = "https://waf.io/waf-2.0.25";
                hash = "sha256-IRmc0iDM9gQ0Ez4f0quMjlIXw3mRmcgnIlQ5cNyOONU=";
              };
            in
            super.wxpython.overrideAttrs {
              disabled = null;
              postPatch = ''
                cp ${waf_2_0_25} bin/waf-2.0.25
                chmod +x bin/waf-2.0.25
                substituteInPlace build.py \
                  --replace-fail "wafCurrentVersion = '2.0.24'" "wafCurrentVersion = '2.0.25'" \
                  --replace-fail "wafMD5 = '698f382cca34a08323670f34830325c4'" "wafMD5 = 'a4b1c34a03d594e5744f9e42f80d969d'" \
                  --replace-fail "distutils.dep_util" "setuptools.modified"
              '';
            };
        };
      };
      python3Packages = python3.pkgs;
    })
  ];

  environment.systemPackages = with pkgs; [
    #godot_git
    #opentoonz
  ];


  hardware.uinput.enable = true;
  # https://rbf.dev/blog/2020/05/custom-nixos-build-for-raspberry-pis/#building-on-nixos-using-nixos-generators
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];


  #boot.initrd.kernelModules = [ "amdgpu" ];
  # https://discourse.nixos.org/t/amd-gpu-optimal-settings/27648/2
  #services.xserver.videoDrivers = [ "amdgpu" ];

  boot.zfs.extraPools = [ "stuff" ];
  
  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];



  #boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_8;

  # nixpkgs.config.packageOverrides = pkgs: pkgs.lib.recursiveUpdate pkgs {
  #   linuxKernel.kernels.linux_6_8 = pkgs.linuxKernel.kernels.linux_6_8.override {
  #     # ignoreConfigErrors = false;
  #     # autoModules = true;
  #     # kernelPreferBuiltin = true;
  #     extraStructuredConfig = with lib.kernel; {
  #       AMD_PRIVATE_COLOR = yes;
  #     };
  #     # extraMakeFlags = [
  #     #   "-DAMD_PRIVATE_COLOR"
  #     # ];
  #   };
  #   # linuxKernel.kernels.linux_6_8 = pkgs.linuxKernel.kernels.linux_6_8.overrideDerivation (old: {
  #   #   NIX_CFLAGS_COMPILE = [ "-DAMD_PRIVATE_COLOR" ];
  #   # });
  # };


  # boot.kernelParams = [
  #   "amdgpu.msi=0"
  #   "amdgpu.aspm=0"
  #   "amdgpu.runpm=0"
  #   "amdgpu.bapm=0"
  #   "amdgpu.vm_update_mode=0"
  #   "amdgpu.exp_hw_support=1"
  #   "amdgpu.sched_jobs=64"
  #   "amdgpu.sched_hw_submission=4"
  #   "amdgpu.lbpw=0"
  #   "amdgpu.mes=1"
  #   "amdgpu.mes_kiq=1"
  #   "amdgpu.sched_policy=1"
  #   "amdgpu.ignore_crat=1"
  #   "amdgpu.no_system_mem_limit"
  #   "amdgpu.smu_pptable_id=0"
  # ];


  
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

  programs.corectrl.enable = true;

  #environment.variables.AMD_VULKAN_ICD = "RADV";


  services.gvfs.enable = true;



  networking = {
    hostName = "pc";
    hostId = "7c980de5"; # head -c 8 /etc/machine-id
    firewall = {
      allowedTCPPorts = [ ];
    };
    hosts = {
      #"127.0.0.1" = [ "youtube.com" "youtu.be" "www.youtube.com" ];
    };
    
  };


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;

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

}
