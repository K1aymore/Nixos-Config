{ config, lib, pkgs, firefox-nightly, ... }:

{
  config = lib.mkIf config.klaymore.gui.enable {

    environment.systemPackages = with pkgs;
      if config.klaymore.programs.firefox.nightly
      then [ firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin ]
      else [ firefox ];

    home-manager.users.klaymore.programs.firefox = {
      enable = false;
      package = lib.mkIf config.klaymore.programs.firefox.nightly firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;

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
        #   # hide empty tab groups
        #   userChrome = "
        #     #tabbrowser-tabs tab-group:not(:has(.tabbrowser-tab:not([hidden]))) .tab-group-label-container {
        #       margin: 0 !important;
        #       max-height: 0 !important;
        #       max-width: 0 !important;
        #       padding: 0 !important;
        #       visibility: hidden !important;
        #     }";
      };

    };

  };
}
