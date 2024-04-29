{ config, pkgs, ... }:

{

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #displayManager.lightdm.enable = false;
    # Configure keymap in X11
    xkb.layout = "us";
    # xkbOptions = "eurosign:e";

    libinput = {
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

  };


}
