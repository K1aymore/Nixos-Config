{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.klaymore.gui.niri.enable {

    programs.niri.enable = true;
    xdg.portal.config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ]; # "gtk" or "kde"
    };
    programs.ssh.startAgent = lib.mkForce false; # has own alternative

    environment.systemPackages = with pkgs; [ 
      xwayland-satellite
    ];

  };
}
