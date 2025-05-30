{ pkgs, nixpkgs, config, systemSettings, ports, ... }:


{

  imports = [
    ./packages.nix

    ./programs.nix
    ./aliases.nix
    ./fish.nix
    ./catppuccin.nix
    ./espanso.nix

    ./fonts

  ] ++ nixpkgs.lib.optionals (systemSettings.yggdrasilPeers != []) [
    ./yggdrasil.nix
  ];



  # Select internationalisation properties.
  console = {
    font = "ter-i23b";
    # keyMap = "us";
    useXkbConfig = true;
    /* earlySetup = true; */
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry = {
    nixpkgs.flake = nixpkgs; # pin nixpkgs version
    nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
  };
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
  nix.package = pkgs.lix; # some programs don't use lix, no compiling

  environment.variables = {
    GPG_TTY = "$(tty)";
    GTK_USE_PORTAL = "1";
    EDITOR = "micro";
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
      ${systemSettings.serverLan} serverlan
    '';
  };

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
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "adbusers" "input" "plugdev" "corectrl" ];
  };


  home-manager.backupFileExtension = "backup";
  
  home-manager.users.klaymore = {
    home.stateVersion = "24.05";
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;


}
