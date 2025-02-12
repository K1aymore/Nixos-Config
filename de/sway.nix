{ pkgs, ... }:

{

  imports = [
    ./wayland.nix
    ./x11.nix
    ./pipewire.nix
  ];


  home-manager.users.klaymore.wayland.windowManager.sway = {
    enable = true;
    config = {
      input."*" = {
        xkb_layout = "us,us";
        xkb_variant = "colemak,";
        xkb_options = "grp:win_space_toggle";
        tap = "enabled";
        natural_scroll = "enabled";
        dwt = "disabled";
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
        inner = 8;
        smartGaps = true;
        smartBorders = "on";
      };
      window.border = 0;

    };
    extraConfig = "
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      bindsym XF86AudioRaiseVolume exec 'pamixer -i 5'
      bindsym XF86AudioLowerVolume exec 'pamixer -d 5'
      bindsym XF86AudioMute exec 'pamixer -t'

    ";
  };

  programs.light.enable = true;

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

}
