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
    neededForBoot = true;
  };

  fileSystems."/home/klaymore" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=777" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/fbe3f613-943e-47ff-8ba9-930360c36f81";
    fsType="ext4";
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/11787f82-b1b8-43b4-be7e-876d7f500a4c";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/nix/persist" = {
    device = "/dev/disk/by-uuid/8bc5deba-3537-427b-9d9d-472dacd191eb";
    fsType = "ext4";
    neededForBoot = true;
  };


  boot.zfs.extraPools = [ "zfs2" ];

  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/dbbe870f-c951-4465-8ef0-0e4517afd415"; }
  #   ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
