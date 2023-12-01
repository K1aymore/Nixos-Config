{ ... }:


{


  home-manager.users.klaymore.home.persistence."/synced/Nix/persist/home" = {
    removePrefixDirectory = true;
    allowOther = true;
    directories = [
      "Flatpak/.var/app"
    ];
  };


}

