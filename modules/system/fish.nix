{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.klaymore.system.fish.enable {

    users.users.klaymore.shell = pkgs.fish;    
    programs.fish.enable = true;

    home-manager.users.klaymore.programs.fish = {
      enable = true;
      shellAliases = config.environment.shellAliases;
      interactiveShellInit = ''
        set -gx GPG_TTY (tty)
        set fish_ambiguous_width 2
      '';
      functions = rec {
        run = "NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$argv --impure";
        shell = "NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#$argv --impure";
        mkcd = mkz;
        mkz = "mkdir $argv; z $argv";
      };
    };

  };
}