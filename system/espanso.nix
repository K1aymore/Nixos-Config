{ pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in
{

  home-manager.users.klaymore.services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
    matches = { default = [
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
        trigger = "peopel";
        replace = "people";
      }

      {
        trigger = "jsut";
        replace = "just";
      }


      {
        trigger = "]par";
        replace = "(";
      }
      {
        trigger = "]cpar";
        replace = ")";
      }

      {
        trigger = "]one";
        replace = "1";
      }
      {
        trigger = "]two";
        replace = "2";
      }
      {
        trigger = "]three";
        replace = "3";
      }
      {
        trigger = "]four";
        replace = "4";
      }
      {
        trigger = "]five";
        replace = "5";
      }
      {
        trigger = "]six";
        replace = "6";
      }
      {
        trigger = "]seven";
        replace = "7";
      }
      {
        trigger = "]eight";
        replace = "8";
      }
      {
        trigger = "]nine";
        replace = "9";
      }
      {
        trigger = "]zero";
        replace = "0";
      }
      {
        trigger = "]ten";
        replace = "10";
      }

      {
        trigger = "]at";
        replace = "@";
      }
      {
        trigger = "]dollar";
        replace = "$";
      }
      {
        trigger = "]ast";
        replace = "*";
      }
      {
        trigger = "]hash";
        replace = "#";
      }
    ];
    
    };
  };


}
