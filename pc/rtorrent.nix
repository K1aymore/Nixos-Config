{ pkgs, lib, config, ... }:

{
  services.rtorrent = {
    enable = true;
    openFirewall = true;
    port = 57213;
    user = "klaymore";
    group = "users";
    downloadDir = "/synced/HugeArchive/Seed";
  };

}
