{ pkgs, lib, config, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

}
