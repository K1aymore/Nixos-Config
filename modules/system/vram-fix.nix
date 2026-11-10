{ config, lib, pkgs, inputs, ... }:

{
  config = lib.mkIf config.klaymore.system.vram-fix {

    boot.kernelPackages = pkgs.linuxPackages_latest;

    nixpkgs.overlays = [
      (final: prev: {
        mesa = prev.mesa.overrideAttrs (old: rec {
          # version = "26.2.1";
          # src = pkgs.fetchFromGitLab {
          #   domain = "gitlab.freedesktop.org";
          #   owner = "mesa";
          #   repo = "mesa";
          #   rev = "mesa-${version}";
          #   hash = "";
          # };
          patches = old.patches ++ [ ./mesa-vram-777966a7cd402248a06603691ec89eb3bf3bade8.patch ];
        });
      })
    ];

  };
}
