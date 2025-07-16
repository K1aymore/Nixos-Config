{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.gui.enable {

    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = false;
      # Configure keymap in X11
      # xkbOptions = "eurosign:e";
    };

    services.libinput = {
      enable = true;
      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };
      # touchpad settings
      touchpad = {
        # accelProfile = "flat";
        naturalScrolling = true;
        disableWhileTyping = false;
      };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

  };
}