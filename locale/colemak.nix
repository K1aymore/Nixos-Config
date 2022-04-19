{ config, pkgs, ... }:


{

  # Select internationalisation properties.
  console.keyMap = "colemak";

  services.xserver.xkbVariant = "colemak";

  environment.variables = {
    XKB_DEFAULT_VARIANT = "colemak";
  };

}
