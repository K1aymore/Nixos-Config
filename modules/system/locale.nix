{ config, lib, pkgs, ... }:

{

  config = {

    time.timeZone = config.klaymore.system.timeZone;
    i18n.defaultLocale = config.klaymore.system.locale;

    services.xserver = {
      xkb.layout = "us";
      xkb.variant = lib.mkIf (config.klaymore.system.kanata == false) (config.klaymore.system.keyboard);
      xkb.options = "compose:ralt";
    };
    environment.variables = {
      XKB_DEFAULT_VARIANT = config.klaymore.system.keyboard;
    };

    # disable for kanata?
    i18n.inputMethod = {
      enable = true;
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
