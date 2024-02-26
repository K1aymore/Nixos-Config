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
      desktopManager.plasma6.enable = lib.mkDefault true;
  };


  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    
  };

  environment.systemPackages = [
    (pkgs.callPackage ./VK_hdr_layer.nix {})
  ];
  
  environment.variables = {
    ENABLE_HDR_WSI = "1";
  };

  programs.dconf.enable = true;

}
