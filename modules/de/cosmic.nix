{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.cosmic.enable {
    klaymore.gui.enable = true;

    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;

    services.system76-scheduler.enable = true;
    programs.ssh.startAgent = lib.mkForce false;

  };
}
