{ pkgs, lib, ... }:

{

  imports = [
    ./x11.nix
    ./wayland.nix
    ./pipewire.nix
  ];

  services.xserver = {
      displayManager.sddm.enable = true;
      displayManager.sddm.settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
  };

  services.desktopManager.plasma6.enable = lib.mkDefault true;

  environment.systemPackages = [
    (pkgs.callPackage ./VK_hdr_layer.nix {})
  ];
  
  environment.variables = {
    ENABLE_HDR_WSI = "1";
  };

  programs.gamescope = {
    package = pkgs.gamescope-wsi;
    /*env = {
      ENABLE_GAMESCOPE_WSI = "1";
      DXVK_HDR = "1";
      DISABLE_HDR_WSI = "1";
      MANGOHUD = "1";
    };
    args = [
      "-f"
      "-F fsr"
      "-h 2160"
      "--force-grab-cursor"
      "--adaptive-sync"
      "--hdr-enabled"
      "--hdr-debug-force-output"
      "--hdr-itm-enable"
      "--steam"
    ];*/
  };

  nixpkgs.overlays = [
    (final: prev: {
      gamescope-wsi = prev.gamescope-wsi.override { enableExecutable = true; };
    })
  ];


  programs.dconf.enable = true;

}
