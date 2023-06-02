{
  services.syncthing.folders."Dotfiles" = {
    path = "/synced/Nix/dotfiles";
    devices = [ "server" "pc" "laptop" "portable" "acer" ];
    ignorePerms = false;
  };
}
