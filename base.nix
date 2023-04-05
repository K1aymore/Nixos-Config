{ config, pkgs, ... }:


{

  imports = [
    ./packages/base.nix

    ./term/programs.nix
    ./term/aliases.nix
    ./term/fish.nix
    ./term/espanso.nix

  ];



  # Select internationalisation properties.
  console = {
    font = "ter-i23b";
    # keyMap = "us";
    useXkbConfig = true;
    /* earlySetup = true; */
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.variables = {
     GPG_TTY = "$(tty)";
  };

  security.polkit.enable = true;

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22000 22067  # syncthing transfers & relay
        3978 3979  # OpenTTD
        1714
      ];
      allowedUDPPorts = [
        21027 22067  # syncthing discovery
        3978 3979   # OpenTTD
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;  # KDE Connect
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;  # KDE Connect
          to = 1764;
        }
      ];
    };

    extraHosts = ''
      172.16.0.115 serverlan
      172.16.0.115:56789 serverlanssh
      192.30.255.113 github.com
    '';
  };

  # security.doas.enable = true;

  hardware.bluetooth.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  boot.initrd.network.enable = true;

  services.fstrim.enable = true; # for ssd trimming

  boot.kernel.sysctl = { # for Syncthing watches
    # Note that inotify watches consume 1kB on 64-bit machines.
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
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
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };



  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/synced/Nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "YN2VCWJ-KOISEL2-4IJKGK4-3AVQSBJ-ZWPNLPS-AUBCY5Q-MYWTZWU-6LIU2AL"; };
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "acer" = { id = "EDKZG5I-43A6ULK-GVGYZYG-74DZIZF-BDR7MKI-EAT6SJG-QQA5IAG-TZUWOAL"; };
      "portable" = { id = "XE2345I-O43URZS-PSHU7ND-27FP3MQ-OZDHQBP-GVQ6MX6-74TSRBX-2VOMGQY"; };
      "pixel" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      "pinephone" = { id = "4XLSS5A-V4FMDW7-SY4F7Y2-EG5KCTD-PMGPYHN-QKP32VU-DKKU6VC-MIOUTAU"; };
      "winpc" = { id = "D2GJW3Q-SGTTOT7-ZSP6B77-CJPN6CA-U3YEITS-REIXCVN-5FEKP3P-JK56RQE"; };
      "cDesk" = { id = "RLFHUVQ-HXAGZ54-DGEN2S3-YRHRWID-D6Q4S4B-PNOCIDP-T2NNWZP-GPY5NQG"; };
      "masterkitty" = { id = "GDGLT7J-TG3BPIS-HL72SHH-32R7W6K-IMHPBP6-WQI5MKS-FPGX2LA-A7QKMAW"; };
    };
  };



  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;


}
