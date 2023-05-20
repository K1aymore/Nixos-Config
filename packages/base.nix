{ pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    #mplus-outline-fonts
    dina-font
    proggyfonts

    #font-awesome
    font-awesome_4
    terminus_font

    comic-mono
    monocraft
    scientifica
    fira-code
  ];


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

    gvfs
    libcdio # cd stuff for kde
    faac # mp4 aac
    faad2
    /* gst_all_1.gst-libav
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly */
    pamixer

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
    tealdeer
    /* git */   # home manager
    nixos-option
    #awscli2
    httrack
    elinks
    links2
    w3m
    openssl

    micro
    xclip
    /* neovim */    # home manager
    universal-ctags
    emacs
    fd
    ranger
    sc-im
    ttyper
    pwgen
    moc
    mpc-cli
    fzf
    tmux
    comma


    # Rust programs
    zellij
    exa
    bat
    gitui
    ripgrep
    du-dust
    bacon
    speedtest-rs

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
    tty-clock


    mullvad-vpn
    /* yggdrasil */
  ];


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;


}
