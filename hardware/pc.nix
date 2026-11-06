{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.loader = {
    # Use the systemd-boot EFI boot loader.
    #     systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      #efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ed2adad0-e1a1-499a-84d1-83ad4109b3bb";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BE58-59A8";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/66e4e3fc-2d0f-4979-80ff-e5f3529a3672"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
