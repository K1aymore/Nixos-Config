{ config, pkgs, ... }:


{

  # Select internationalisation properties.
  #console.keyMap = "us";

  services.xserver.xkbVariant = "qwerty";

  environment.variables = {
    XKB_DEFAULT_VARIANT = "qwerty";
  };

}
