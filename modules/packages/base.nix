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
      groff

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
      efibootmgr

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
      gallery-dl

      micro
      xclip
      /* neovim */    # home manager
      universal-ctags
      fd
      ranger
      sc-im
      ttyper
      pwgen
      # moc
      mpc
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
      carl
      gif-for-cli

      amfora

      ffmpeg-full
      yt-dlp
      r128gain
      mediainfo
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
      neofetch
      tree
      cmatrix
      lolcat
      hello
      vitetris
      asciiquarium
      oneko
      #pmbootstrap
      tty-clock
      
      hspell
      hunspell

      pandoc

      # Coding
      clang
      clang-tools
      gcc
      ghc # Haskell compiler
      sbcl # Lisp compiler
      go
      # nasm # assembly compiler
      # inklecate # Ink compiler/player
      gnumake
      # avalonia-ilspy # .NET exe decompiler
      lldb
      valgrind
      python314

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

      nil # Nix LSP
      nixd
      nixpkgs-fmt

      #android-studio
      #apksigner
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
