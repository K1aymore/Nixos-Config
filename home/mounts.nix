{ config, pkgs, ... }:

let
  dots = /nix/dotfiles;
in
{

  fileSystems."/home/klaymore/.cache" = {
    device = "${dots}/cache";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.config" = {
    device = "${dots}/config";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.local/share" = {
    device = "${dots}/local-share";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.kde" = {
    device = "${dots}/kde";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.gnupg" = {
    device = "${dots}/gnupg";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.vscode-oss" = {
    device = "${dots}/vscode-oss";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.atom" = {
    device = "${dots}/atom";
    options = [ "bind" ];
  };
  fileSystems."/home/klaymore/.aws" = {
    device = "${dots}/aws";
    options = [ "bind" ];
  };

}
