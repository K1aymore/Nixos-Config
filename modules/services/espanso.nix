{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.services.espanso.enable {

    home-manager.users.klaymore.services.espanso = {
      enable = true;
      package = pkgs.espanso-wayland;
      configs.default = {
        toggle_key = "RIGHT_SHIFT";
      };

      matches.default.matches = [
        {
          # Simple text replacement
          trigger = "]espanso";
          replace = "Hi there!";
        }
        {
          # Dates
          trigger = "]date";
          replace = "{{mydate}}";
          vars = [{
            name = "mydate";
            type = "date";
            params = { format = "%m/%d/%Y"; };
          }];
        }
        {
          # Shell commands
          trigger = "]shell";
          replace = "{{output}}";
          vars = [{
            name = "output";
            type = "shell";
            params = { cmd = "echo Hello from your shell"; };
          }];
        }
      ] ++
      # Inserts
      (map (pair: {
        trigger = builtins.elemAt pair 0;
        replace = builtins.elemAt pair 1;
      }) [
        [ "]em" "—" ]
        [ "]en" "–" ]
        [ "]fire" "🔥"]
        [ "]skull" "💀" ]
        [ "]pensive" "😔" ]
        [ "]think" "🤔" ]
        [ "]pinch" "🤏" ]
        [ "]fus" "🇺🇸" ]
        [ "]fse" "🇸🇪" ]
        [ "]fja" "🇯🇵" ]
        [ "]fge" "🇩🇪" ]
        [ "]ffr" "🇫🇷" ]
        [ "]fme" "🇲🇽" ]
        [ "]ftr" "🏳️‍⚧️" ]
        [ "]fpr" "🏳️‍🌈" ]
        [ "]hit" "↗️" ]
        [ "]\\hit" "↘️" ]
        [ "]hst" "⬆️" ]
        [ "]\\hst" "⬇️" ]
        [ "]hli" "▶️" ]
        [ "]\\hli" "◀️" ]
      ]) ++ 
      # Autocorrect
      (map (pair: {
        trigger = builtins.elemAt pair 0;
        replace = builtins.elemAt pair 1; 
        word = true;
      }) [
        [ "peopel" "people" ]
        [ "jsut" "just" ]
        [ "thay" "that" ]
        [ "nad" "and" ]
      ]);
      #++ (map (pair: {
      # trigger = (builtins.elemAt pair 0) + " ";
      # replace = (builtins.elemAt pair 1);
      #}) sitelen-pona-UCSUR.pairsList);


    };

  };
}