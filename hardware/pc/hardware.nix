{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "uas" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "mode=755" "size=500M" ]; # "size=500M"
  };

  fileSystems."/home/klaymore" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "mode=777" "size=2G" ]; # "size=500M"
  };


  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C552-4091";
    fsType = "vfat";
  };


  boot.initrd.luks.devices."luks-nix".device = "/dev/disk/by-uuid/2642c33e-d402-48df-ba22-1929fac80352";
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b7980e87-ee6a-42f8-ad0b-9bb3dbec23de";
    fsType = "ext4";
    neededForBoot = true;
  };



  # Synced
  boot.initrd.luks.devices."luks-synced".device = "/dev/disk/by-uuid/a1d87862-3676-4f71-ab9d-2d63734eb5b2";
  fileSystems."/synced" = {
    device = "/dev/disk/by-uuid/578ff020-2da7-497d-af01-f8983e1c2e40";
    #device = "serverlan:/synced";
    neededForBoot = true;
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
  /*boot.initrd.luks.devices."luks-1200dbe8-1413-479c-8a4f-e8be0b8a21e3".device = "/dev/disk/by-uuid/1200dbe8-1413-479c-8a4f-e8be0b8a21e3";
    fileSystems."/synced/HugeArchive" = {
    device = "/dev/disk/by-uuid/dbad8e8f-a1af-4f78-a078-f4bd75e41434";
    fsType = "ext4";
  };*/

  # Games
  fileSystems."/home/klaymore/.var/app/com.valvesoftware.Steam" = {
    device = "/dev/disk/by-uuid/0c8bb6fb-2568-46cf-b5ee-5452b727d4fc";
    fsType = "ext4";
  };

  fileSystems."/nfs/hugeArchive" = {
    device = "172.16.0.115:/hugeArchive";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/46249488-631c-498e-b600-77d3ba10cbe1"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance"; # powersave
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
