{ config, lib, pkgs, ... }:

{

  config = {

    time.timeZone = config.klaymore.system.timeZone;
    i18n.defaultLocale = config.klaymore.system.locale;

    i18n.extraLocales = [
      "sv_SE.UTF-8/UTF-8"
      "eo/UTF-8"
      "fr_FR.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
    ];


    services.xserver = {
      xkb.layout = "us";
      #xkb.variant = lib.mkIf (config.klaymore.system.kanata == false) (config.klaymore.system.keyboard);
      #xkb.options = "compose:ralt";
    };
    environment.variables = {
      #XKB_DEFAULT_VARIANT = config.klaymore.system.keyboard;
    };

    # needed for kanata support everywhere
    i18n.inputMethod = {
      enable = false; # add package in Plasma
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        anthy
        hangul
        mozc
        table
        table-others
        typing-booster
      ];
    };

  };
}
