{ pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
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
    lm_sensors
    acpi
    beep

    gvfs
    libcdio # cd stuff for kde
    faac # mp4 aac
    faad2
    /* gst_all_1.gst-libav
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly */
    #pamixer

    breakpad
    fwupd
    xdotool
    wtype
    sox

    pdftk
    imagemagick
    bc

    brightnessctl
    playerctl

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
    smartmontools

    networkmanager-openvpn
    openvpn
    wget
    curl
    htop
    man
    tealdeer
    git   # home manager
    nixos-option
    #awscli2
    httrack
    elinks
    links2
    w3m
    openssl
    iperf
    iperf3d
    ventoy
    radeontop
    inetutils
    moreutils
    wireguard-tools
    vnstat

    micro
    xclip
    /* neovim */    # home manager
    universal-ctags
    #emacs
    fd
    ranger
    sc-im
    ttyper
    pwgen
    moc
    mpc-cli
    fzf
    tmux
    lesspass-cli
    croc
    mmv


    # Rust programs
    eza
    bat
    gitui
    ripgrep
    du-dust
    duf
    bacon
    speedtest-rs
    delta
    nh
    bottom
    gping
    lazygit
    lsd

    ffmpeg
    yt-dlp
    r128gain
    mediainfo
    rclone
    poppler
    poppler_utils
    killall

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
    pmbootstrap
    tty-clock
    
    hspell
    hunspell


    mullvad-vpn
    /* yggdrasil */
  ];



}
