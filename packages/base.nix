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
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    usbutils
    diffutils
    pciutils
    nix-diff
    findutils
    utillinux
    gnused
    gnugrep
    gnupg
    ripgrep
    gnutar
    gzip
    xz
    zip
    unzip
    /* tzdata */
    glibc
    glib
    clang
    libva-utils
    gvfs
    libcdio

    brightnessctl

    cryptsetup
    ntfs3g
    exfat
    /* exfatprogs */
    f2fs-tools
    btrfs-progs
    btrfs-heatmap
    zfs

    wget
    curl
    htop
    man
    tealdeer
    nixos-option
    awscli2
    httrack
    elinks

    micro
    xclip
    neovim
    emacs
    fd
    ranger

    ffmpeg
    yt-dlp
    r128gain
    rclone

    ldns
    bind
    php
    nodejs

    pfetch
    neofetch
    tree
    lolcat
    thefuck
    hello
    vitetris
    asciiquarium
    oneko


    mullvad-vpn
    /* yggdrasil */
    kdeconnect
  ];


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;


  programs = {
    java.enable = true;
  };


}
