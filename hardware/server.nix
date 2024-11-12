{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "pata_jmicron" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=755" ];
  };

  fileSystems."/home/klaymore" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "size=1G" "mode=777" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F902-8505";
    fsType="vfat";
  };

  fileSystems."/synced" = {
    device = "/dev/disk/by-uuid/f7b4de5e-00b6-4b2a-b2e2-9ae1fd3df093";
    fsType = "ext4";
    neededForBoot = true;
  };

  /* fileSystems."/synced/HugeArchive" = {
    device = "/dev/disk/by-uuid/ee575e80-6b75-4abe-854a-bf31fcf3d2b9";
    fsType = "ext4";
  }; */

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/a4c05ff8-0f49-42f5-b6fc-4d14f1bd10e3";
    fsType = "ext4";
  };

  boot.zfs.extraPools = [ "zfs1" ];

  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/dbbe870f-c951-4465-8ef0-0e4517afd415"; }
  #   ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
