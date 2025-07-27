{ pkgs, ... }:

{

  config = {

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
      git-crypt
      nixos-option
      #awscli2
      httrack
      elinks
      links2
      w3m
      openssl
      iperf
      iperf3d
      #ventoy
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
      fzy
      tmux
      lesspass-cli
      croc
      mmv


      # Rust programs
      eza
      bat
      gitui
      ripgrep
      ripgrep-all
      du-dust
      duf
      dysk
      bacon
      speedtest-rs
      delta
      nh
      bottom
      gping
      lazygit
      lsd
      tokei
      television

      amfora

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
      marksman

      pfetch
      neofetch
      tree
      cmatrix
      lolcat
      hello
      vitetris
      asciiquarium
      oneko
      pmbootstrap
      tty-clock
      
      hspell
      hunspell



      # Coding
      clang
      clang-tools
      gcc
      gcc11
      ghc # Haskell compiler
      sbcl # Lisp compiler
      # nasm # assembly compiler
      # inklecate # Ink compiler/player
      gnumake
      # avalonia-ilspy # .NET exe decompiler
      lldb
      valgrind


      rustup
      #cargo
      #rustc
      rustfmt
      wasm-pack # Rust WebAssembly
      rust-analyzer
      pkg-config
      xorg.libX11
      libxkbcommon
      alsa-lib

      nil # Nix LSP
      nixd
      nixpkgs-fmt

      #android-studio
      #apksigner
      jdk17
      jdk11
      jdk8
      jdt-language-server

      php
      deno # for catppuccin userstyles
      typescript

      #jetbrains.idea-community
      docker
      #arduino

      sqlite

      /* qtcreator */
      /* libsForQt5.full */
      cmake
      gdb

      glibc_multi

      #neovide
      #neovim-qt
      #gnvim

      distrobox
    ];

    # https://github.com/Mic92/nix-ld
    programs.nix-ld.enable = true;
    # https://github.com/Mic92/envfs
    services.envfs.enable = true;

    programs = {
      java = {
        enable = true;
        package = pkgs.jdk;
      };
    };

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    # virtualisation.docker = {
    #   enable = true;
    #   rootless.enable = true;
    # };
    users.users.klaymore.extraGroups = [ "docker" ];

  };
}