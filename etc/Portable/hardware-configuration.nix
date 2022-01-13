# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "uas" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=3G" "mode=755" ];
    };
    
  fileSystems."/home/klaymore" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=4G" "mode=777" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b6743e58-50e2-4774-99a5-cb110bd0f5e9";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."nix".device = "/dev/disk/by-uuid/0f3abd33-d2d2-47cc-a96f-cf2f8a0c0fc8";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/93BD-AED6";
      fsType = "vfat";
    };

  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/7886c01d-d753-4395-8e10-d98a0b57cabf";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."data".device = "/dev/disk/by-uuid/380b9589-4e43-416d-a474-175041d03246";

  fileSystems."/synced/Archive" =
    { device = "/dev/disk/by-uuid/bcfc8710-26b8-4b2d-a0e5-ac856fe92d74";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."Archive".device = "/dev/disk/by-uuid/bb813aab-e636-4b0a-97c0-be4c3b379e5d";

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
