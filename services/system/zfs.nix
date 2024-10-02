{ config, pkgs, lib, ... }:


let
  isUnstable = config.boot.zfs.package == pkgs.zfsUnstable;
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (
      (!isUnstable && !kernelPackages.zfs.meta.broken)
      || (isUnstable && !kernelPackages.zfs_unstable.meta.broken)
    )
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{

  # ZFS support
  boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.grub.copyKernels = true; # often true anyways
  services.zfs.autoScrub.enable = true;
  boot.kernelParams = [ "nohibernate" ]; # can cause ZFS corruption
  boot.zfs.forceImportRoot = false;
  
  assertions = [ 
    {

    }
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

}
