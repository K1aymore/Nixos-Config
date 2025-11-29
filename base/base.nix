{ config, lib, pkgs, ports, nixpkgs, ... }:

{

  # Select internationalisation properties.
  console = {
    #font = "ter-i23b";
    # keyMap = "us";
    useXkbConfig = true;
    /* earlySetup = true; */
  };

  hardware.uinput.enable = true;
  services.gvfs.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry = {
    nixpkgs.flake = nixpkgs; # pin nixpkgs version
    nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
  };
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
  nix.settings.cores = 6;
  nixpkgs = {
    config.allowUnfree = true;
  };

  # Use Lix
  nix.package = pkgs.lixPackageSets.stable.lix;
  nixpkgs.overlays = [
    (final: prev: {
      inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
    })
    (final: prev: {
      swt = prev.swt.overrideAttrs (old: { # fix compile error
        NIX_CFLAGS_COMPILE = "-Wno-error";
      });
    })
  ];

  # stop Nix build if taking too much RAM
  systemd = {
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "50%";
    };
    services."nix-daemon".serviceConfig.Slice = "nix-daemon.slice";

    # If a kernel-level OOM event does occur anyway,
    # strongly prefer killing nix-daemon child processes
    services."nix-daemon".serviceConfig.OOMScoreAdjust = 1000;
  };

  # Nice Nix builds to keep system running nicely
  systemd.services.nix-daemon.serviceConfig = {
    Nice = lib.mkForce 15;
    IOSchedulingClass = lib.mkForce "idle";
    IOSchedulingPriority = lib.mkForce 7;
  };

  services.journald.extraConfig = "SystemMaxUse=1G";


  environment.variables = {
    GPG_TTY = "$(tty)";
    GTK_USE_PORTAL = "1";
    FLAKE = config.klaymore.configPath;
    NH_FLAKE = config.klaymore.configPath;
    #XDG_CONFIG_HOME = config.home-manager.users.klaymore.home.homeDirectory; # breaks everything
  };

  security.polkit.enable = true;

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        ports.openttd1
        ports.openttd2
      ];
      allowedTCPPortRanges = [
        {
          from = 1714; # KDE Connect
          to = 1764;
        }
      ];
      allowedUDPPorts = config.networking.firewall.allowedTCPPorts;
      allowedUDPPortRanges = config.networking.firewall.allowedTCPPortRanges;
    };
    
    #nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    # If using dhcpcd:
    #dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    #networkmanager.dns = "none";

    extraHosts = ''
      ${config.klaymore.serverLan} serverlan
    '';
  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  # programs.nix-index = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   enableFishIntegration = true;
  # };
  programs.command-not-found.enable = false;


  # security.doas.enable = true;

  hardware.bluetooth.enable = true;
  services.vnstat.enable = true;

  # Printers
  services.printing = {
    enable = true;
    browsing = true;
    stateless = true;
    drivers = with pkgs; [ 
      brlaser
      #canon-cups-ufr2
      canon-capt
      gutenprint
      gutenprintBin
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  # cool but kinda useless
  #services.gpm.enable = true;

  #boot.initrd.network.enable = true;

  services.fstrim.enable = true; # for ssd trimming

  boot.kernel.sysctl = {
    # for Syncthing watches
    # Note that inotify watches consume 1kB on 64-bit machines.
    "fs.inotify.max_user_watches" = 1048576; # default:  8192
    "fs.inotify.max_user_instances" = 1024; # default:   128
    "fs.inotify.max_queued_events" = 32768; # default: 16384
  };



  users.mutableUsers = false;
  # Set a root password, consider using initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.users.root.initialHashedPassword = "$6$ZKUuN3EirBtn6029$xe9DTh1bfkg6CheJsBtQzGJURFh8Wr9hla.5gX2ouNfqZ5kUhP/Xy0TCNuidUG.Ld9mfoY8.Hc0QHm634BU9q0";
  users.users.klaymore = {
    isNormalUser = true;
    initialHashedPassword = "$6$ZKUuN3EirBtn6029$xe9DTh1bfkg6CheJsBtQzGJURFh8Wr9hla.5gX2ouNfqZ5kUhP/Xy0TCNuidUG.Ld9mfoY8.Hc0QHm634BU9q0";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "adbusers" "input" "uinput" "plugdev" "corectrl" "gamemode" ];
  };


  programs.fuse.userAllowOther = true;

  home-manager.backupFileExtension = "backup";
  home-manager.users.klaymore = {
    home.homeDirectory = lib.mkForce "/home/klaymore";

    programs.home-manager.enable = true;

    home.file = {
      # export PATH=”$PATH:/synced/Sync/Linux/BashScripts”  # this breaks sudo
      ".bashrc".text = ''
        export GPG_TTY=$(tty)
      '';
    };
  };

  home-manager.users.klaymore.home.file.".sqliterc".text = ".mode column";


  home-manager.users.klaymore.home.stateVersion = "24.05";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
