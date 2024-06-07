{ pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in
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
      

      {
        trigger = "]em";
        replace = "—";
      }
      {
        trigger = "]en";
        replace = "–";
      }

      
      
      
      {
        trigger = "peopel";
        replace = "people";
      }
      {
        trigger = "jsut";
        replace = "just";
      }
      {
        trigger = "Jsut";
        replace = "Just";
      }

    ];
    
    
  };


}
