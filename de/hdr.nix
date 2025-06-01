{ pkgs, ... }:

{

  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    # Needed for MPV
    #(pkgs.callPackage ./VK_hdr_layer.nix {})
    gamescope-wsi
  ];
  
  environment.variables = {
    #ENABLE_HDR_WSI = "1";
  };


  programs.gamescope = {
    enable = true;
    #capSysNice = true; # seems unnecesarry with Zen kernel
    package = pkgs.gamescope-wsi;
    args = [ ];
    env = {
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      gamescope-wsi = prev.gamescope-wsi.override { enableExecutable = true; };
    })
  ];

}
