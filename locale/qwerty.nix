{ config, pkgs, ... }:


{

  # Select internationalisation properties.
  console.keyMap = "us";

  services.xserver.xkbVariant = "qwerty";

}
