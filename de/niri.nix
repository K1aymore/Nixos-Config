{ pkgs, lib, config, ... }:

{

  options = {
    myOptions.niri.enable = lib.mkEnableOption "Niri";
  };


  config = lib.mkIf config.myOptions.niri.enable {

		environment.systemPackages = with pkgs; [
			niri
			fuzzel
			alacritty
		];



    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        #xdg-desktop-portal
        #xdg-desktop-portal-kde
        #xdg-desktop-portal-wlr

        # for Firefox cursor, fixes Vesktop?
        xdg-desktop-portal-gnome
      ];
    };






	};

}
