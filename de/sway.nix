{ config, pkgs, lib, ... }:

{

  imports = [
    ./wayland.nix
  ];

  /* programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
  }; */

  home-manager.users.klaymore.wayland.windowManager.sway = {
    enable = true;
    config = {
      input = {
         type-keyboard = { xkb_variant = "colemak"; };
      };

      modifier = "Mod2";

      keybindings = let
        modifier = config.home-manager.users.klaymore.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      };

      terminal = "alacritty";


      gaps = {
        inner = 10;
      };
      window.border = 1;

    };
  };


  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
    wob
    #mako # notification daemon # annoying on plasma
    alacritty # Alacritty is the default terminal in the config
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    wofi
  ];

}
