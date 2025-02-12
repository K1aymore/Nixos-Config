{ pkgs, lib, ... }:

{

  # ZFS support
  boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.copyKernels = true; # often true anyways
  services.zfs.autoScrub.enable = true;
  boot.kernelParams = [ "nohibernate" ]; # can cause ZFS corruption
  boot.zfs.forceImportRoot = false;
  
  boot.zfs.devNodes = "/dev/disk/by-id";

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

}
