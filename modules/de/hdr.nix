{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.gui.hdr {

    environment.systemPackages = with pkgs; [
      gamescope-wsi
    ];

    programs.gamescope = {
      enable = true;
      #capSysNice = true; # seems unnecesarry with Zen kernel
      package = pkgs.gamescope-wsi;
      # args = [ ];
    };

    nixpkgs.overlays = [
      (final: prev: {
        gamescope-wsi = prev.gamescope-wsi.override { enableExecutable = true; };
      })
    ];

  };
}