{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz";
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";

in
{

  imports = [
    (import "${home-manager}/nixos")
  ];


  programs.fuse.userAllowOther = true;




  home-manager.users.klaymore = {

    impotrs = [ "${impermanence}/home-manager.nix" ];

    programs.home-manager.enable = true;

    home.persistence."/nix/persist/cache" = {       # app cache (last opened file, downloaded data, etc)
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "KeepassXC"
        "Tealdeer"
        "qBittorrent"
        "Bash"
      ];
    };

    home.persistence."/nix/persist/config" = {     # app config for specifically this computer
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
      ];
      files = [
      ];
    };

    home.persistence."/nix/cfg/dotfiles" = {         # synced dotfiles - shared with other computers
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "Firefox"
        "Plasma"
        "Clementine"
      ];
    };

  };




}
