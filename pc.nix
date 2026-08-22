{ lib, pkgs, mesa-vram, ... }@pcInputs:

{

  klaymore = {
    powerful = true;
    localIP = "172.16.0.123";

    gui = {
      enable = true;
      hdr = true;
      scaling = "1.75";
      plasma.enable = true;
    };
    pipewire.enable = true;

    programs = {
      emacs.enable = true;
    };

    servers = {
      syncplay.enable = true;
    };

    services = {
      mullvad.enable = true;
      syncthing.enable = true;
    };

    system = {
      impermanence.system.enable = true;
      kanata.enable = true;
      locale = "sv_SE.UTF-8";
      zram.enable = true;
    };
  };

  # specialisation.cosmic.configuration = {
  #   klaymore.gui.plasma.enable = lib.mkForce false;
  #   klaymore.gui.cosmic.enable = true;
  # };

  nixpkgs.overlays = [
    (final: prev: {
      #   mesa = pkgs.callPackage ./mesa-vram (with pkgs; {
      #     mesa-libclc = pkgs.mesa-libclc;
      #     inherit lib
      #       bison
      #       buildPackages
      #       directx-headers
      #       elfutils
      #       expat
      #       fetchCrate
      #       fetchFromGitLab
      #       file
      #       flex
      #       glslang
      #       spirv-tools
      #       intltool
      #       libdisplay-info
      #       libdrm
      #       libgbm
      #       libglvnd
      #       libpng
      #       libunwind
      #       libva-minimal
      #       llvmPackages
      #       lm_sensors
      #       meson
      #       ninja
      #       pkg-config
      #       python3Packages
      #       runCommand
      #       rust-bindgen
      #       rust-cbindgen
      #       rustc
      #       spirv-llvm-translator
      #       stdenv
      #       udev
      #       valgrind-light
      #       vulkan-loader
      #       wayland
      #       wayland-protocols
      #       wayland-scanner
      #       libxcb-keysyms
      #       libxxf86vm
      #       libxrandr
      #       libxfixes
      #       libxext
      #       libx11
      #       xorgproto
      #       libxshmfence
      #       libxcb
      #       zstd;
      #   });
      mesa = prev.mesa.overrideAttrs (old: {
        patches = old.patches ++ [ ./mesa-vram-777966a7cd402248a06603691ec89eb3bf3bade8.patch ];
      });
      # mesa = prev.mesa.overrideAttrs (old: {
      #   version = "26.3.0";
      #   src = pkgs.fetchFromGitLab {
      #     domain = "gitlab.freedesktop.org";
      #     owner = "pixelcluster";
      #     repo = "mesa";
      #     rev = "777966a7cd402248a06603691ec89eb3bf3bade8";
      #     hash = "sha256-fyYGgCgnreBRgUc9ZEkEaT0NogeGGOWVzzfEK+rCRok=";
      #   };
      # });
    })
  ];

  # nixpkgs.config.packageOverrides = pkgs: {
  #   mesa = ((pkgs.mesa.override {
  #     # driDrivers = [ ];
  #   }).overrideAttrs (attrs: {
  #     name = "mesa-vram";
  #     src = mesa-vram;
  #   }));
  # };

  environment.systemPackages = with pkgs;
    [
      #godot_git
      #opentoonz
      briar-desktop

      dmemcg-booster
      kcgroups
      plasma-foreground-booster
    ];


  # https://rbf.dev/blog/2020/05/custom-nixos-build-for-raspberry-pis/#building-on-nixos-using-nixos-generators
  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # https://www.reddit.com/r/NixOS/comments/1u47cnb/nixos_2605_can_be_used_with_gccarch_x8664v3/
  nix.settings.system-features = [ "gccarch-znver2" "gccarch-x86-64-v3" "gccarch-x86-64-v2" "gccarch-x86-64" ];

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  jovian.hardware.has.amd.gpu = true;

  systemd.services.dmemcg-booster = {
    enable = true;
    # overrideStrategy = "asDropin";
    wantedBy = [ "multi-user.target" ];
    description = "Service for enabling and controlling dmem cgroup limits for boosting foreground games, system-level";
    serviceConfig = {
      ExecStart = "${pkgs.dmemcg-booster}/bin/dmemcg-booster --use-system-bus";
    };
  };

  systemd.user.services.dmemcg-booster = {
    enable = true;
    # overrideStrategy = "asDropin";
    wantedBy = [ "graphical-session-pre.target" ];
    description = "Service for enabling and controlling dmem cgroup limits for boosting foreground games, user-level";
    serviceConfig = {
      ExecStart = "${pkgs.dmemcg-booster}/bin/dmemcg-booster";
    };
  };

  boot.kernelPackages =
    let
      linux_sgx_pkg = { fetchurl, buildLinux, ... } @ args:

        buildLinux (args // rec {
          version = "7.2.0";
          modDirVersion = version;

          src = fetchurl {
            url = "https://gitlab.freedesktop.org/pixelcluster/kernel/-/archive/2d900c1f9793fdb23bbbd6a42585b72c555266b7/kernel-2d900c1f9793fdb23bbbd6a42585b72c555266b7.tar.gz";
            # After the first build attempt, look for "hash mismatch" and then 2 lines below at the "got:" line.
            # Use "sha256-....." value here.
            hash = "sha256-4LcA5/PRUmOn/x8lKGWufJuZj2WU6zSRQC8MZl69Lzk=";
          };
          kernelPatches = [ ];

          structuredExtraConfig = with lib.kernel; {
            # INTEL_SGX = yes;
          };

          extraMeta.branch = "7.2";
        } // (args.argsOverride or { }));
      linux_sgx = pkgs.callPackage linux_sgx_pkg { };
    in
    lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux_sgx);

  #boot.initrd.kernelModules = [ "amdgpu" ];
  # https://discourse.nixos.org/t/amd-gpu-optimal-settings/27648/2
  #services.xserver.videoDrivers = [ "amdgpu" ];


  #boot.extraModulePackages = with config.boot.kernelPackages; [ amdgpu-pro ];


  #programs.adb.enable = true;


  hardware.graphics =
    let
      attrs = oa: {
        name = "mesa-vram";
        src = mesa-vram;
        nativeBuildInputs = oa.nativeBuildInputs ++ [ pkgs.glslang pkgs.cmake pkgs.pkg-config pkgs.pkgconf ];
        # mesonFlags = oa.mesonFlags ++ [ "-Dvulkan-layers=device-select,overlay" ];
        # postInstall = oa.postInstall + ''
        #   mv $out/lib/libVkLayer* $drivers/lib
        #   layer=VkLayer_MESA_device_select
        #   substituteInPlace $drivers/share/vulkan/implicit_layer.d/''${layer}.json \
        #     --replace "lib''${layer}" "$drivers/lib/lib''${layer}"
        #   layer=VkLayer_MESA_overlay
        #   substituteInPlace $drivers/share/vulkan/explicit_layer.d/''${layer}.json \
        #     --replace "lib''${layer}" "$drivers/lib/lib''${layer}"
        # '';
      };

      vramPatch = old: {
        patches = old.patches ++ [ ./mesa-vram-777966a7cd402248a06603691ec89eb3bf3bade8.patch ];
      };
    in
    with pkgs; {
      enable = true;
      # package = (mesa.overrideAttrs vramPatch);
      # package32 = (pkgsi686Linux.mesa.overrideAttrs vramPatch);
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

  #environment.sessionVariables.AMD_VULKAN_ICD = "RADV";


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
