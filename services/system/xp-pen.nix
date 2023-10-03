{ config, pkgs, ... }:


{

  # XP-Pen Deco 1 v2

  services.xserver.digimend.enable = true;

  services.xserver.inputClassSections = [
    ''
      Identifier "XP-Pen 10 inch PenTablet"
      MatchUSBID "28bd:0905"
      MatchIsTablet "on"
      MatchDevicePath "/dev/input/event*"
      Driver "wacom"
    ''
    ''
      Identifier "XP-Pen 10 inch PenTablet"
      MatchUSBID "28bd:0905"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "libinput"
    ''
  ];



}




