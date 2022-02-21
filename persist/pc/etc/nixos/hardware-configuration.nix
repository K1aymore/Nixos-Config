# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/home/klaymore" =
    { device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AA62-C2F1";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/a9b59612-4aee-4bea-ae76-2432be9b8fdc";
      fsType = "ext4";
    };

  fileSystems."/synced" =
    { device = "/dev/disk/by-uuid/578ff020-2da7-497d-af01-f8983e1c2e40";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-a1d87862-3676-4f71-ab9d-2d63734eb5b2".device = "/dev/disk/by-uuid/a1d87862-3676-4f71-ab9d-2d63734eb5b2";

  fileSystems."/synced/Huge Archive" =
    { device = "/dev/disk/by-uuid/764e306b-807f-4fe8-b9ad-8401c384f40e";
      fsType = "ext4";
    };

  fileSystems."/Games" = {
    device = "/dev/disk/by-uuid/01D8197C83229370";
    fsType = "ntfs";
  };

  boot.initrd.luks.devices."luks-89ebb9a7-f363-49c1-9e30-80b04bd3fdef".device = "/dev/disk/by-uuid/89ebb9a7-f363-49c1-9e30-80b04bd3fdef";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7e864f4a-f5fe-4e1a-8b02-3d5db4dc19cd"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
