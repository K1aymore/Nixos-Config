{ pkgs, ... }:

{

  #services.espanso.enable = true;
  
  home-manager.users.klaymore.services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
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
    (map (input: {
      trigger = builtins.elemAt input 0;
      replace = builtins.elemAt input 1;
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
    (map (input: {
      trigger = builtins.elemAt input 0;
      replace = builtins.elemAt input 1;
      word = true;
      propagate_case = true;
    }) [
      [ "peopel" "people" ]
      [ "jsut" "just" ]
      [ "thay" "that" ]
    ]);

    
    
  };


}
