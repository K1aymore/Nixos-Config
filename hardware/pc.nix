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
    options = [ "size=25G" "mode=755" ]; # "size=500M"
  };

  fileSystems."/home/klaymore" = {
    device = "/dev/disk/by-uuid/bd091aa1-d529-4801-a095-64a96379fbcb";
    fsType = "ext4";
    #options = [ "mode=777" ]; # "size=2G"
  };

  #fileSystems."/home/klaymore" = {
  #  device = "none";
  #  fsType = "tmpfs";
  #  options = [ "mode=777" ]; # "size=500M"
  #};


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



  boot.initrd.luks.devices."luks-synced".device = "/dev/disk/by-uuid/a1d87862-3676-4f71-ab9d-2d63734eb5b2";
  fileSystems."/synced" = {
    device = "/dev/disk/by-uuid/578ff020-2da7-497d-af01-f8983e1c2e40";
    #device = "serverlan:/synced";
    neededForBoot = true;
    fsType = "ext4";
  };


  boot.zfs.extraPools = [ "stuff" ];

  # Stuff
  /*fileSystems."/mainStuff" = {
    device = "stuff/main";
    fsType = "zfs";
  };*/

  /* fileSystems."/synced/HugeArchive" = {
    device = "serverlan:/HugeArchive";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];  # "x-systemd.automount" "noauto"
  }; */


  fileSystems."/nfs/stuff" = {
    device = "10.0.0.125:/zfs2/stuff";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" "noatime" ];
  };

  /*swapDevices = [
    { 
      device = "/dev/disk/by-uuid/46249488-631c-498e-b600-77d3ba10cbe1";
      priority = 2;
    }
  ];*/

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
