{ config, lib, ... }:

{
  
  config = lib.mkIf config.klaymore.gui.enable {
    hardware.opentabletdriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;
  };
}