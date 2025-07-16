{ config, ... }:

{

  config = {

    time.timeZone = config.klaymore.system.timeZone;
    i18n.defaultLocale = config.klaymore.system.locale;

    services.xserver = {
      xkb.layout = "us";
      xkb.variant = config.klaymore.system.keyboard;
    };
    environment.variables = {
      XKB_DEFAULT_VARIANT = config.klaymore.system.keyboard;
    };

  };
}