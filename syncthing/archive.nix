{
  services.syncthing.folders."Archive" = {
    path = "/synced/Archive";
    devices = [ "server" "pc" "portable" "acer" ];
    ignorePerms = false;
  };
}
