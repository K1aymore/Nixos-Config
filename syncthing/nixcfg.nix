{
  services.syncthing.settings.folders."NixCfg" = {
    path = "/synced/Nix/cfg";
    devices = [ "server" "pc" "laptop" "portable" "pinephone" "pixel" "winpc" "acer" ];
    ignorePerms = false;
  };
}
