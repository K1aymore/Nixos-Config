# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  # List packages installed in system profile. To search, run:
  # $ nix search wget

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {

  imports = [
    # import stuff here
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  
  environment.systemPackages = with pkgs; [
    usbutils
    diffutils
    pciutils
    nix-diff
    findutils
    utillinux
    gnused
    gnugrep
    gnutar
    gzip
    xz
    zip
    unzip
    tzdata
    glibc

    brightnessctl
    tlp

    cryptsetup
    ntfs3g
    exfat
    exfatprogs
    f2fs-tools

    wget
    curl
    htop
    man
    tealdeer

    micro
    xclip
    neovim
    emacs
    fd

    ffmpeg
    yt-dlp
    r128gain
    rclone

    ldns
    bind
    php
    nodejs
    adoptopenjdk-icedtea-web

    lolcat
    thefuck

    elinks

    mullvad-vpn
  ];


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;

}









