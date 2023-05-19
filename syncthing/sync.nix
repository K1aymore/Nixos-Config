{
  services.syncthing.settings.folders."Sync" = {
    path = "/synced/Sync";
    devices = [ "server" "pc" "laptop" "portable" "pinephone" "pixel" "winpc" "acer" ];
    ignorePerms = false;
  };
}
