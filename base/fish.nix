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
      run = "NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$argv --impure";
    };
  };


  home-manager.users.klaymore.programs.starship = 
    let
      flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
    in
    {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    
    settings = {
      add_newline = true;

      format = "$all"; # Remove this line to disable the default prompt format
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
      
      palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d23"; # Replace with the latest commit hash
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
      
  };



}
