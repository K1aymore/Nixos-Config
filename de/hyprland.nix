{ lib, pkgs, config, systemSettings, ... }:

{

  options = {
    myOptions.hyprland = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "use hyprland";
    };
  };


  config = lib.mkIf config.myOptions.hyprland {

  environment.systemPackages = with pkgs; [
  	wofi
  	grimblast
    waybar
  ];
  
  services.xserver.displayManager.lightdm.enable = false;

  programs.hyprland.enable = true;

  home-manager.users.klaymore.wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.variables = ["--all"];
  };


  home-manager.users.klaymore.wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    "$terminal" = "alacritty";
    "$fileManager" = "dolphin";
    "$menu" = "wofi --show drun";

    exec-once = "$terminal";

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
    };


    monitor = [
      "DP-1, 3840x2160@160, 0x0, 1.666667, vrr, 2"
      "HDMI-A-1, 1920x1080@60, 2304x-90, 1"
      "DP-3, 1600x900@59.98, -1600x380, 1"
      ", preferred, auto, 1"
    ];

    experimental = {
      xx_color_management_v4 = true;
      #wide_color_gamut = true;
      #hdr = true; # ow yep that works
    };

	  input = {
	    sensitivity = (-0.5);
      touchpad = {
        natural_scroll = true;
        tap-and-drag = false;
      };
    };
    
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind = [
      ", Print, exec, grimblast copy area"
      "$mod, T, exec, $terminal"
      "$mod, D, exec, $menu"
      "$mod, Q, killactive, "
      "$mod, M, exit, "
      "$mod, F, exec, $fileManager"
      "$mod, V, togglefloating, "
      "$mod, P, pseudo," # dwindle
      "$mod, J, togglesplit," # dwindle

      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (map (x: [
        "$mod, ${toString x}, workspace, ${toString x}"
        "$mod SHIFT, ${toString x}, movetoworkspace, ${toString x}"
      ])
      (lib.lists.range 1 10))
    );
  };


  home-manager.users.klaymore.programs.waybar = {
    enable = true;
    systemd.enable = true;
    #style = "";
  };
  
};
}
