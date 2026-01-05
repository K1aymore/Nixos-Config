{ config, lib, pkgs, ... }:

{

  home-manager.users.klaymore.programs.firefox = lib.mkIf config.klaymore.gui.enable {
    enable = true;

    profiles.default = {
      settings = {
        "font.language.group" = "x-western";
        "font.name-list.cursive.x-western" = "cursive, nasin-nanpa, Helvetica, Noto Sans Mono CJK JP";
        "font.name-list.monospace.x-unicode" = "monospace, nasin-nanpa, Helvetica, Fairfax Hax HD, Noto Sans Mono CJK JP";
        "font.name-list.monospace.x-western" = "monospace, nasin-nanpa, Helvetica, Noto Sans Mono CJK JP";
        "font.name-list.sans-serif.x-unicode" = "sans-serif, nasin-nanpa, Helvetica, Fairfax HD, Noto Sans CJK JP";
        "font.name-list.sans-serif.x-western" = "sans-serif, nasin-nanpa, Helvetica, Fairfax HD, Noto Sans CJK JP";
        "font.name-list.serif.x-unicode" = "serif, nasin-nanpa, Helvetica, Noto Sans CJK JP";
        "font.name-list.serif.x-western" = "serif, nasin-nanpa, Helvetica, Noto Sans CJK JP";
        "font.name.monospace.x-unicode" = "nasin-nanpa";
        "font.name.monospace.x-western" = "nasin-nanpa";
        "font.name.sans-serif.x-unicode" = "nasin-nanpa";
        "font.name.sans-serif.x-western" = "nasin-nanpa";
        "font.name.serif.x-unicode" = "nasin-nanpa";
        "font.name.serif.x-western" = "nasin-nanpa";
        "font.size.monospace.x-unicode" = 11;
        "font.size.monospace.x-western" = 11;
      };
    };

  };
}
