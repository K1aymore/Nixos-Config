{ pkgs, lib, ... }:

{

  imports = [

  ];


  #chaotic.hdr.enable = true;
  #chaotic.hdr.specialisation.enable = false;

  chaotic.hdr.wsiPackage = pkgs.gamescope-wsi_git;

  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    # Needed for MPV
    (pkgs.callPackage ./VK_hdr_layer.nix {})
    gamescope-wsi_git
  ];
  
  environment.variables = {
    ENABLE_HDR_WSI = "1";
  };


  programs.gamescope = {
    enable = true;
    capSysNice = true;
    package = pkgs.gamescope-wsi_git;
    args = [ ];
    env = {
      ENABLE_HDR_WSI = "0";
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      gamescope-wsi_git = prev.gamescope-wsi_git.override { enableExecutable = true; };
    })
  ];

}