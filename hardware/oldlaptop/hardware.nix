{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=1G" "mode=755" ];
    };

  fileSystems."/home/klaymore" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=1G" "mode=777" ];
    };


  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/58CA-48CB";
      fsType = "vfat";
    };


  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/e92586b9-9be2-41ab-b27d-c97dc366a409";
      fsType = "ext4";
    };


  boot.initrd.luks.devices."luks_synced".device = "/dev/disk/by-uuid/d2a4996d-315a-4c05-b942-d73571996dd6";
  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/e50d45dd-afbb-4043-90ab-8d8bb0507fcc";
      fsType = "ext4";
      neededForBoot = true;
    };


  swapDevices = [ ];

  #powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # performance
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
