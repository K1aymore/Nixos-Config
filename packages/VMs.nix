{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    qemu
    virtualbox
    virt-manager
  ];


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "klaymore" ];

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  users.users.klaymore.extraGroups = [ "libvirtd" ];

}
