{ pkgs, ... }:


{

  services.zerotierone.enable = true;

  environment.systemPackages = with pkgs; [
    zerotierone
  ];


}