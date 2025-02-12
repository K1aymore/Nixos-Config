{ ... }:

{

  # Select internationalisation properties.
  # console.keyMap = "colemak";

  services.xserver.xkb.variant = "colemak";

  environment.variables = {
    XKB_DEFAULT_VARIANT = "colemak";
  };

}
