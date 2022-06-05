{ config, pkgs, ... }:

let
  pers = "/nix/persist/home";
in
{

  fileSystems."/home/klaymore/.config/autostart" = {
    device = "${pers}/autostart";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/state/pipewire" = {
    device = "${pers}/Pipewire/pipewire";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/state/wireplumber" = {
    device = "${pers}/Pipewire/wireplumber";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/pulse" = {
    device = "${pers}/Pipewire/pulse";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/Element" = {
    device = "${pers}/Element/config";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.pki" = {
    device = "${pers}/Element/pki";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.mozilla" = {
    device = "${pers}/firefox";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.ssh" = {
    device = "${pers}/ssh";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/Mullvad VPN" = {
    device = "${pers}/mullvad";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share/qBittorrent" = {
    device = "${pers}/qBittorrent/local";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/qBittorrent" = {
    device = "${pers}/qBittorrent/config";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.cache/qBittorrent" = {
    device = "${pers}/qBittorrent/cache";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share/polymc" = {
    device = "${pers}/polymc";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.wine" = {
    device = "${pers}/wine";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.var" = {
    device = "${pers}/Flatpak/var";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share/flatpak" = {
    device = "${pers}/Flatpak/local";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.steam" = {
    device = "${pers}/Steam/steam";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share/Steam" = {
    device = "${pers}/Steam/local";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.itch" = {
    device = "${pers}/Itch/itch";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/itch" = {
    device = "${pers}/Itch/config";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share/grapejuice" = {
    device = "${pers}/grapejuice";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config/Session" = {
    device = "${pers}/session";
    options = [ "bind" ];
  };
}
