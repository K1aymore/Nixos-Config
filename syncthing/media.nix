{
  services.syncthing.folders."Media" = {
    path = "/synced/Media";
    devices = [ "server" "pc" "laptop" "portable" "pinephone" "pixel" "winpc" "acer" ];
    ignorePerms = false;
  };
}
