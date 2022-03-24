{ config, pkgs, ... }:

{

  imports = [
      ./base.nix
      ./locale/qwerty.nix
      ./locale/losAngeles.nix
      ./system/pipewire.nix
      ./de/plasma.nix

      ./packages/gui.nix
      ./packages/games.nix
      ./packages/coding.nix

      /* ./system/opentablet.nix */

      ./system/ipfs.nix
      ./pc/syncplay.nix
      /* ./pc/i2pd.nix */
      /* ./server/minecraft.nix */

      ./impermanence/system.nix
      ./impermanence/home.nix
    ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      /* rocm-opencl-icd
      rocm-opencl-runtime */
      /* vaapiVdpau
      libvdpau-va-gl */
      amdvlk
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  services.gvfs.enable = true;

  networking = {
    hostName = "pc";
    hostId = "7c980de5";  # head -c 8 /etc/machine-id
    firewall = {
      allowedTCPPorts = [ 22000 22067 55434 57213 57227 61007 ];
      allowedUDPPorts = [ 21027 22067 55434 57213 57227 61007 ];
    };
  };


  /* services.boinc = {
    enable = true;
    dataDir = "/nix/persist/appdata/BOINC";
  };
  users.users.boinc.extraGroups = [ "video" ]; */


  services.syncthing.relay.port = 61007;
  services.syncthing.folders = {
      "Sync" = {
        path = "/synced/Sync";
        devices = [ "server" "laptop" "portable" "phone" ];
        ignorePerms = false;
      };
      "Dotfiles" = {
        path = "/nix/dotfiles";
        devices = [ "server" "laptop" "portable" ];
        ignorePerms = false;
      };
      "NixCfg" = {
        path = "/nix/cfg";
        devices = [ "server" "laptop" "portable" "phone" ];
        ignorePerms = false;
      };
      "Projects" = {
        path = "/synced/Projects";
        devices = [ "server" "laptop" "portable" ];
        ignorePerms = false;
      };
      "Archive" = {
        path = "/synced/Archive";
        devices = [ "server" "portable" ];
        ignorePerms = false;
      };
      /* "Huge Archive" = {
        path = "/synced/HugeArchive";
        devices = [ "server" ];
        ignorePerms = false;
      }; */
      "Ellida Sync" = {
        path = "/synced/EllidaSync";
        devices = [ "server" "laptop" "portable" "cDesk" ];
        ignorePerms = false;
      };
      "Ellida Projects" = {
        path = "/synced/EllidaProjects";
        devices = [ "server" "laptop" "portable" "cDesk" ];
        ignorePerms = true;
      };
      "Websites" = {
        path = "/synced/Websites";
        devices = [ "server" "laptop" "portable" "phone" ];
        ignorePerms = false;
      };
  };





}
