{ config, pkgs, ... }:

let
  scripts = "/synced/Sync/Linux/BashScripts";
in {


  users.users.klaymore.shell = pkgs.fish;
  
  
  programs.fish = {
    enable = true;
  };


  home-manager.users.klaymore.programs.fish = {
    enable = true;
    shellAliases = config.environment.shellAliases;
    interactiveShellInit = "set -gx GPG_TTY (tty)";
    functions = {
      run = "nix run nixpkgs#$argv";
    };
  };


  home-manager.users.klaymore.programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;

      /* format = lib.concatStrings [   # Default is fine anyways https://starship.rs/config/#prompt
        "$shlvl$directory"
        "$git_branch$git_commit$git_state$git_metrics$git_status"
        "$line_break"
        "$jobs$battery$time$status$container$shell$character"
      ]; */

      scan_timeout = 30;
      /* character = {
        success_symbol = "❯(bold green)";
        error_symbol = "❯(bold red)";
      }; */
      #command_timeout = 1000;
    };
  };



}
