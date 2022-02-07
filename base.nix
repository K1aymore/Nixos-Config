{ config, pkgs, ... }:


{

  imports = [
    ./packages/base.nix
    ./bash/aliases.nix
    # ./home-manager/home-manager.nix
  ];



  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts

    font-awesome
    font-awesome_4
  ];


  hardware.opengl.driSupport32Bit = true;

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22000 22067 ];  # syncthing transfers & relay
      allowedUDPPorts = [ 21027 22067 ];  # syncthing discovery
    };

    extraHosts = ''
      172.16.0.115 serverlan
      172.16.0.115:56789 serverlanssh
    '';
  };

  # security.doas.enable = true;

  hardware.bluetooth.enable = true;

#   boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
#   boot.supportedFilesystems = [ "zfs" ];




  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    relay.enable = true;
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "SRJBN6A-45PWKAY-LTPIPVI-4MP35LJ-DW3P3UD-YUBRIM4-L4EN7HV-GCW3MAO"; };
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "portable" = { id = "XRMEW3S-FABIUWA-BDL7YIX-AO2JD77-F6P2NOD-PRDCDV4-QZIZEHX-Q6ASDQS"; };
      "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      "cDesk" = { id = "RLFHUVQ-HXAGZ54-DGEN2S3-YRHRWID-D6Q4S4B-PNOCIDP-T2NNWZP-GPY5NQG"; };
    };
  };




  users.mutableUsers = false;

  # Set a root password, consider using initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.users.root.initialHashedPassword = "$6$Ts7LPml3ldgPr8$lSpGAQt8UWMCSg4/NAmkh7BWE5NIbhWiINGHCk0vdSeUTpge6qXHYMvtBGMMTf1DGO.JmuKraPwgJIy3WeeKP1";

  users.users.klaymore = {
    isNormalUser = true;
    initialHashedPassword = "$6$8TWC64JUVZ$uXCFLG0XECGYrdpC38rHoPLeujvCtQzykwHYh78VKy.oH9bfDyME1lXyhcK7DN877czSGPg0DgbuFNotq3XXj1";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };






  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;





}
