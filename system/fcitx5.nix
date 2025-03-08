{ pkgs, ... }:

{

  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5 = {
    plasma6Support = true;
    waylandFrontend = true;
    addons = with pkgs; [
      fcitx5-mozc
    ];
  };

}