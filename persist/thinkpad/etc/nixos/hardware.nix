{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=6G" "mode=755" ];
    };

  fileSystems."/home/klaymore" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=1G" "mode=777" ];
    };


  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6854-F6C2";
      fsType = "vfat";
    };


  boot.initrd.luks.devices."luks_nix".device = "/dev/disk/by-uuid/d3af92e1-ce30-4592-8a25-0b7294aa9a02";
  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/73448cbf-7e7f-4512-975e-6874e8afcfad";
      fsType = "ext4";
    };


  boot.initrd.luks.devices."luks_synced".device = "/dev/disk/by-uuid/29dbbd7d-eed7-4aec-949c-86fdae64a0f4";
  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/24c365fd-1c7b-49c0-b5cb-e2807aee729c";
      fsType = "ext4";
      neededForBoot = true;
    };


  boot.initrd.luks.devices."swap".device = "/dev/disk/by-uuid/5474ae55-a9ff-4bfa-a0c6-7e5c70db28d8";
  swapDevices = [ { device = "/dev/disk/by-uuid/282f0806-40d5-48f5-a65f-944f4f7948f1"; } ];

#   powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # performance
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
