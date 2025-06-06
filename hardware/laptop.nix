{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader = {
    # Use the systemd-boot EFI boot loader.
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

#     grub = {
#       enable = true;
#       efiSupport = true;
#       #efiInstallAsRemovable = true;
#       device = "nodev";
#     };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/188a6e36-ed18-4f14-94ab-d64f15ea0299";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/42a94f20-5e45-40ca-bc35-07685bd3eb75";
      fsType = "ext4";
      neededForBoot = true;
      options = [ "noatime" "nodiratime" ];
    };

  boot.initrd.luks.devices."luks-93bf8f5e-7fff-450c-96c6-1034fa503be2".device = "/dev/disk/by-uuid/93bf8f5e-7fff-450c-96c6-1034fa503be2";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/90B6-CF61";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  boot.initrd.luks.devices."luks-a6321344-ea78-45ee-8f5d-21f3059f09d4".device = "/dev/disk/by-uuid/a6321344-ea78-45ee-8f5d-21f3059f09d4";
  swapDevices = [ { device = "/dev/disk/by-uuid/5e4fceac-8af0-4a3b-9108-f27461ce7d63"; } ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # performance
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.fwupd.enable = true;
}
