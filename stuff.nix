{ config, pkgs, ... }:


{

  imports =
    [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix
      
      # ./home-manager/home-manager.nix     # already imported in base.nix

      # ./system/xp-pen.nix

      # ./impermanence/system.nix
      # ./impermanence/home.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Scan for other operating systems
  boot.loader.grub.useOSProber = true;




  networking = {
    hostName = "pc";


    firewall = {
      enable = false;

      allowedUDPPorts = [
        8055
      ];
      allowedTCPPorts = [
        8055
      ];
    };
  };




  services.xserver.displayManager.defaultSession = "plasma5";
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "klaymore";


  # boot.kernelPackages = pkgs.linuxPackages_5_10_75;




  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/nix/persist/appdata/syncthing";
    openDefaultPorts = false;
    user = "klaymore";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    declarative = {
      overrideDevices = true;
      overrideFolders = true;
      devices = {
        "laptop" = { id = "34AVXMA-IPYWWB6-42RQTSB-KKWKSN5-MYUB4II-AJBV5WI-OWG65XZ-FDZKMA3"; };
        "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
        "phone" = { id = "2L2KW2W-BBEZ7LT-Z7OZDUO-RKTIXMW-LYWDTNR-Q2TABSU-4V7GM7R-VPSKIAZ"; };
      };
      folders = {
        "Sync" = {
          path = "/synced/Sync";
          devices = [ "server" "laptop" "phone" ];
          ignorePerms = false;
        };
        "NixCfg" = {
          path = "/nix/cfg";
          devices = [ "server" "laptop" "phone" ];
          ignorePerms = false;
        };
        "Projects" = {
          path = "/synced/Projects";
          devices = [ "server" "laptop" ];
          ignorePerms = false;
        };
        "Archive" = {
          path = "/synced/Archive";
          devices = [ "server" "laptop" ];
          ignorePerms = false;
        };
        "Huge Archive" = {
          path = "/synced/Huge Archive";
          devices = [ "server" ];
          ignorePerms = false;
        };
        "Ellida Sync" = {
          path = "/synced/Ellida Sync";
          devices = [ "server" "laptop" ];
          ignorePerms = false;
        };
      };
    };
  };





  # Mullvad

  boot.extraModulePackages = with config.boot.kernelPackages; [ pkgs.wireguard ];
  environment.systemPackages = [ pkgs.wireguard pkgs.wireguard-tools ];

  networking.wg-quick.interfaces = {
  wg-mullvad = {
    address = [ "10.64.128.86/32" "fc00:bbbb:bbbb:bb01::1:8055/128" ];
    listenPort = 51820;
    dns = [ "193.138.218.74" ]; # mullvad public dns
    privateKeyFile = "/nix/persist/config/Mullvad/LA-Key";
    peers = [
      {
        publicKey = "bVRtvE1WQQmAjnC1BybSXz2r9VHLp9DKwsEZ3UzELjg=";
        allowedIPs = [ "0.0.0.0" ]; # Only send communication through mullvad if it is in the range of the given ips, allows for split tunneling
        endpoint = "[2a0d:5600:8:3f::a69f]:51820"; # my selected mullvad enpoint
      }
    ];
  };
  };




}




