{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz";
  dots = /nix/persist/dotfiles;
in
{

  imports = [
    (import "${home-manager}/nixos")
  ];



  home-manager.users.klaymore = {

    home.file = {
      ".bashrc".source = "/synced/Sync/Linux/bashrc";
    };

    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName  = "Klaymore";
        userEmail = "klaymorer@protonmail.com";
      };

    };

  };


}
