{ pkgs, lib, config, ... }:

{

  imports = [
    ./locale/qwerty.nix
    ./locale/losAngeles.nix
    
    ./de

    ./packages/gui.nix
    ./packages/games.nix
    ./packages/coding.nix
    #./packages/video-editing.nix
    ./packages/mpd.nix
    
    ./packages/steam.nix

    #./packages/VMs.nix
    # ./system/ipfs.nix
    #./pc/i2p.nix

    #./system/opentablet.nix
    #./system/macroboard.nix

    ./system/syncthing.nix
    ./system/zram.nix
    #./system/zfs.nix

    ./impermanence/system.nix
    #./impermanence/home.nix
  ];

  myOptions.plasma.enable = true;

  # specialisation.niri.configuration = {
  #   myOptions.plasma.enable = lib.mkForce false;
  #   myOptions.niri.enable = true;
  # };

  # nixpkgs.overlays = [
  #   
  #   (final: prev: rec {
  #     python3 = prev.python3.override {
  #       packageOverrides = self: super: {
  #         wxpython =
  #           let
  #             waf_2_0_25 = pkgs.fetchurl {
  #               url = "https://waf.io/waf-2.0.25";
  #               hash = "sha256-IRmc0iDM9gQ0Ez4f0quMjlIXw3mRmcgnIlQ5cNyOONU=";
  #             };
  #           in
  #           super.wxpython.overrideAttrs {
  #             disabled = null;
  #             postPatch = ''
  #               cp ${waf_2_0_25} bin/waf-2.0.25
  #               chmod +x bin/waf-2.0.25
  #               substituteInPlace build.py \
  #                 --replace-fail "wafCurrentVersion = '2.0.24'" "wafCurrentVersion = '2.0.25'" \
  #                 --replace-fail "wafMD5 = '698f382cca34a08323670f34830325c4'" "wafMD5 = 'a4b1c34a03d594e5744f9e42f80d969d'" \
  #                 --replace-fail "distutils.dep_util" "setuptools.modified"
  #             '';
  #           };
  #       };
  #     };
  #     python3Packages = python3.pkgs;
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    #godot_git
    #opentoonz
    (pkgs.callPackage ./packages/hdrGlfw/package.nix {})
    briar-desktop
  ];


  hardware.uinput.enable = true;
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


  services.gvfs.enable = true;


  networking = {
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
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

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
