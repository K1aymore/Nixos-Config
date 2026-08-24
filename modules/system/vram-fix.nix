{ config, lib, pkgs, linux-git, ... }:

{
  config = lib.mkIf config.klaymore.system.vram-fix {

    boot.kernelPackages =
      let
        linux_vram_pkg = { fetchurl, buildLinux, ... } @ args:

          buildLinux (args // rec {
            version = "7.2.0";
            modDirVersion = version;

            src = linux-git; # fixes are merged into master
            kernelPatches = [ ];

            structuredExtraConfig = with lib.kernel; {
              # INTEL_SGX = yes;
            };

            extraMeta.branch = "master";
          } // (args.argsOverride or { }));
        linux_vram = pkgs.callPackage linux_vram_pkg { };
      in
      lib.mkForce (lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux_vram));


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


    environment.systemPackages = with pkgs; [
      dmemcg-booster
      kcgroups
      plasma-foreground-booster
    ];


    systemd.services.dmemcg-booster = {
      enable = true;
      # overrideStrategy = "asDropin";
      wantedBy = [ "multi-user.target" ];
      description = "Service for enabling and controlling dmem cgroup limits for boosting foreground games, system-level";
      serviceConfig = {
        ExecStart = "${pkgs.dmemcg-booster}/bin/dmemcg-booster --use-system-bus";
      };
    };

    systemd.user.services.dmemcg-booster = {
      enable = true;
      # overrideStrategy = "asDropin";
      wantedBy = [ "graphical-session-pre.target" ];
      description = "Service for enabling and controlling dmem cgroup limits for boosting foreground games, user-level";
      serviceConfig = {
        ExecStart = "${pkgs.dmemcg-booster}/bin/dmemcg-booster";
      };
    };

  };
}
