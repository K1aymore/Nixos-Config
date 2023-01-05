{ config, pkgs, lib, ... }:

{

  imports = [
    ./wayland.nix
    ./x11.nix
  ];


  home-manager.users.klaymore.wayland.windowManager.sway = {
    enable = true;
    config = {
      input."*" = {
        xkb_layout = "us";
        xkb_variant = "colemak";
        tap = "enabled";
        natural_scroll = "enabled";
      };

      #modifier = "Mod2";

      /* keybindings = let
        modifier = config.home-manager.users.klaymore.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      }; */

      terminal = "alacritty";

      #window.titlebar = false;
      #menu = "wofi";

      gaps = {
        inner = 7;
      };
      window.border = 2;

    };
    extraConfig = "
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

    ";
  };

  programs.light.enable = true;

}
