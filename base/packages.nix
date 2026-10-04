{ config, lib, pkgs, ... }:

{
  config = {

    environment.systemPackages = with pkgs; [
      # Libraries
      gvfs
      libcdio # cd stuff for kde
      faac # mp4 aac
      faad2
      /* gst_all_1.gst-libav
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly */
      #pamixer
      # breakpad
      hunspell

      libxcrypt
      cryptsetup
      ntfs3g
      exfat
      exfatprogs
      f2fs-tools
      btrfs-progs
      btrfs-heatmap
      zfs
      nfs-utils
      libnfs
      smartmontools
      efibootmgr

      # Utils
      coreutils
      usbutils
      diffutils
      pciutils
      findutils
      # utillinux
      gnused
      gnugrep
      gnupg
      gnutar
      gzip
      xz
      zip
      unzip
      unrar
      # tzdata
      glibc
      glib
      clang
      libva-utils
      lshw
      lm_sensors
      acpi

      brightnessctl
      playerctl

      networkmanager-openvpn
      openvpn
      wget
      curl
      htop
      man
      git # home manager
      git-crypt
      bash
      zsh
      fish

      parted

      fwupd
      xdotool
      wtype

      ffmpeg-full
      yt-dlp
      rsgain
      mediainfo
      pdftk
      imagemagick
      pandoc
      gallery-dl

      # Terminal Tools
      bc
      beep
      sox
      groff

      tealdeer
      nixos-option
      #awscli2
      httrack
      elinks
      # links2
      w3m
      openssl
      iperf
      iperf3d
      #ventoy
      radeontop
      inetutils
      wireguard-tools
      vnstat

      micro
      neovim # home manager
      universal-ctags
      fd
      ranger
      pwgen
      # moc
      fzf
      fzy
      tmux
      croc
      mmv
      recutils # GNU text database

      # Rust programs
      eza
      bat
      ripgrep
      ripgrep-all
      dust
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
      gif-for-cli

      amfora

      rclone
      poppler
      poppler-utils
      killall

      ldns
      bind
      php
      nodejs
      marksman

      pfetch
      fastfetch
      tree
      cmatrix
      lolcat
      hello
      vitetris
      asciiquarium
      oneko
      #pmbootstrap
      tty-clock

      # Coding
      clang
      clang-tools
      gcc
      ghc # Haskell compiler
      sbcl # Lisp compiler
      chicken # Scheme
      janet
      jpm
      guile
      go
      # nasm # assembly compiler
      # inklecate # Ink compiler/player
      gnumake
      # avalonia-ilspy # .NET exe decompiler
      lldb
      valgrind
      python314
      ledger
      hledger

      dotnet-sdk
      dotnet-runtime

      rustup
      #cargo
      #rustc
      rustfmt
      wasm-pack # Rust WebAssembly
      rust-analyzer
      pkg-config
      libX11
      libxkbcommon
      alsa-lib

      # nil # Nix LSP
      nixd
      nixfmt

      #android-studio
      #apksigner
      jdk8
      jdt-language-server

      php
      deno # for catppuccin userstyles
      typescript

      docker
      #arduino

      sqlite

      cmake
      gdb
      glibc_multi

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
      enable = false;
      #dockerCompat = true;
    };
    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
    };
    users.users.klaymore.extraGroups = [ "docker" ];

    home-manager.users.klaymore.programs = {
      micro.enable = true;
      bat.enable = true;
      eza.enable = true;
      delta.enable = true;
    };

  };
}
