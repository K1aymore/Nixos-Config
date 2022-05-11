# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "size=1G" "mode=755" ];
  };

  fileSystems."/home/klaymore" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "size=1G" "mode=777" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AA62-C2F1";
    fsType = "vfat";
  };


  # Nix
  boot.initrd.luks.devices."luks-5a7b63e6-7124-4dea-9931-586d66f22c9d".device = "/dev/disk/by-uuid/5a7b63e6-7124-4dea-9931-586d66f22c9d";
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d2bef521-48a3-4f71-a30b-7b30172007ad";
    fsType = "btrfs";
    options = [ "compress-force=zstd:2" ];
  };


  # Synced
  boot.initrd.luks.devices."luks-a1d87862-3676-4f71-ab9d-2d63734eb5b2".device = "/dev/disk/by-uuid/a1d87862-3676-4f71-ab9d-2d63734eb5b2";
  fileSystems."/synced" = {
    device = "/dev/disk/by-uuid/578ff020-2da7-497d-af01-f8983e1c2e40";
    #device = "serverlan:/synced";
    fsType = "ext4";
  };


  # Stuff
  fileSystems."/synced/Stuff" = {
    device = "stuff/main";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  /* fileSystems."/synced/HugeArchive" = {
    device = "serverlan:/HugeArchive";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];  # "x-systemd.automount" "noauto"
  }; */


  # HugeArchive
  boot.initrd.luks.devices."luks-1200dbe8-1413-479c-8a4f-e8be0b8a21e3".device = "/dev/disk/by-uuid/1200dbe8-1413-479c-8a4f-e8be0b8a21e3";
  fileSystems."/synced/HugeArchive" = {
    device = "/dev/disk/by-uuid/dbad8e8f-a1af-4f78-a078-f4bd75e41434";
    fsType = "ext4";
  };


  fileSystems."/Games" = {
    device = "/dev/disk/by-uuid/01D83C2C20EC6320";
    fsType = "ntfs";
  };

  /* swapDevices = [
    { device = "/dev/disk/by-uuid/7e864f4a-f5fe-4e1a-8b02-3d5db4dc19cd"; }
  ]; */

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
