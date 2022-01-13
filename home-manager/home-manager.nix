{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz";
  dots = /nix/dotfiles;
in
{

  imports = [
    (import "${home-manager}/nixos")
  ];


  home-manager.users.klaymore = {
    home.homeDirectory = "/home/klaymore";

    home.file = {
      ".bashrc".source = "/synced/Sync/Linux/bashrc";

      ".atom/atom-discord".source = "${dots}/Atom/.atom/atom-discord";
      ".atom/packages".source = "${dots}/Atom/.atom/packages";
      ".atom/config.cson".source = "${dots}/Atom/.atom/config.cson";
      ".atom/github.cson".source = "${dots}/Atom/.atom/github.cson";

      ".config" = {
        source = "${dots}/Plasma/.config";
        recursive = true;
      };
    };

    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName  = "Klaymore";
        userEmail = "klaymorer@protonmail.com";
      };
    };


    home.stateVersion = "21.11";
  };


}
