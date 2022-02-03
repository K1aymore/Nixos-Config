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

  networking.networkmanager.enable = true;
  networking.enableIPv6 = true;

  # security.doas.enable = true;

  hardware.bluetooth.enable = true;

  boot.initrd.supportedFilesystems = ["zfs"]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];


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


  networking.extraHosts = ''
    172.16.0.115 serverlan
    172.16.0.115:56789 serverlanssh
  '';





  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;





}
