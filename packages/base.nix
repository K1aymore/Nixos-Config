{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

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
    # utillinux
    gnused
    gnugrep
    gnupg
    ripgrep
    gnutar
    gzip
    xz
    zip
    unzip
    unrar
    /* tzdata */
    glibc
    glib
    clang
    libva-utils
    lshw
    libxcrypt

    gvfs
    libcdio  # cd stuff for kde
    faac   # mp4 aac
    faad2
    /* gst_all_1.gst-libav
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly */

    breakpad
    fwupd
    xdotool
    wtype
    sox

    pdftk
    imagemagick

    brightnessctl

    cryptsetup
    ntfs3g
    exfat
    /* exfatprogs */
    f2fs-tools
    btrfs-progs
    btrfs-heatmap
    zfs
    nfs-utils
    libnfs
    parted

    wget
    curl
    htop
    man
    tldr
    /* git */   # home manager
    nixos-option
    awscli2
    httrack
    elinks
    links2
    w3m
    openssl

    micro
    xclip
    /* neovim */    # home manager
    universal-ctags
    vim
    emacs
    fd
    ranger
    bat
    sc-im
    ttyper
    pwgen
    moc
    /* ncmpcpp */ # HM
    mpc-cli
    /* starship */ # HM
    fzf
    /* zoxide */  # HM
    tmux
    zellij
    comma

    ffmpeg
    yt-dlp
    r128gain
    mediainfo
    rclone

    ldns
    bind
    php
    nodejs

    pfetch
    neofetch
    tree
    cmatrix
    lolcat
    thefuck
    hello
    vitetris
    asciiquarium
    oneko
    openttd
    pmbootstrap


    mullvad-vpn
    /* yggdrasil */
  ];


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;


}
