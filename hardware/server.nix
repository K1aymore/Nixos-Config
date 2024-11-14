{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "pata_jmicron" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  #boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/disk/by-id/ata-CT240BX500SSD1_1911E178602F"; # or "nodev" for efi only


  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=755" ];
  };

  fileSystems."/home/klaymore" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=777" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/c6922e76-ac69-4c53-814e-af31d997e831";
    fsType="ext4";
  };

  #fileSystems."/synced" = {
  #  device = "/dev/disk/by-uuid/f7b4de5e-00b6-4b2a-b2e2-9ae1fd3df093";
  #  fsType = "ext4";
  #  neededForBoot = true;
  #};

  /* fileSystems."/synced/HugeArchive" = {
    device = "/dev/disk/by-uuid/ee575e80-6b75-4abe-854a-bf31fcf3d2b9";
    fsType = "ext4";
  }; */

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/1ba1f601-9259-43e1-a0bc-a80e01fba71c";
    fsType = "ext4";
  };

  boot.zfs.extraPools = [ "zfs2" ];

  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/dbbe870f-c951-4465-8ef0-0e4517afd415"; }
  #   ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
