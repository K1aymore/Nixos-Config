# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/home/klaymore" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/a8bd979e-fa71-46f5-b2c4-d8dfc8bdb61b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-666c7a02-fe93-4af0-bd0e-41ba2ace2052".device = "/dev/disk/by-uuid/666c7a02-fe93-4af0-bd0e-41ba2ace2052";

  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/a4c7891f-bc43-4403-ba77-410f7c58b8c5";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-112baf35-dd03-49e2-baed-c9ede97eb328".device = "/dev/disk/by-uuid/112baf35-dd03-49e2-baed-c9ede97eb328";

  fileSystems."/synced/Archive" =
    { device = "/dev/disk/by-uuid/bcfc8710-26b8-4b2d-a0e5-ac856fe92d74";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-bb813aab-e636-4b0a-97c0-be4c3b379e5d".device = "/dev/disk/by-uuid/bb813aab-e636-4b0a-97c0-be4c3b379e5d";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DDC1-2082";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
