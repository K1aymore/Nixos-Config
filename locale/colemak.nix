{ config, pkgs, ... }:


{

  # Select internationalisation properties.
  console.keyMap = "colemak";

  services.xserver.xkbVariant = "colemak";

}
