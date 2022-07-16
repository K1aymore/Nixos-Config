{ pkgs, lib, config, ... }:

{

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
    ];
    configuration =
      "media_dir = /synced/Media/Music";

  };

}
