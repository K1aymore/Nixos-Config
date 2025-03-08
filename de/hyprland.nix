{ lib, systemSettings, ... }:

{
  imports = [
    ./wayland.nix
    ./x11.nix
  ] ++ lib.optionals systemSettings.hdr [
    ./hdr.nix
  ];

  programs.hyprland.enable = true;


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



    monitor = ",preferred,auto,auto";

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
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );
  };
}
