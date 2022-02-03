{ config, pkgs, ... }:


let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz";
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";

in
{

  imports = [
    (import "${home-manager}/nixos")
  ];


  programs.fuse.userAllowOther = true;


  home-manager.users.klaymore = {
    home.homeDirectory = "/home/klaymore";

    imports = [ "${impermanence}/home-manager.nix" ];

    programs = {
      home-manager.enable = true;

      git = {
        enable = true;
        userName  = "Klaymore";
        userEmail = "klaymorer@protonmail.com";
      };
    };



    home.persistence."/nix/persist/home" = {
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "Tealdeer/.cache/tealdeer"
        "Element/.config/Element"
        "Element/.pki"
        "SSH/.ssh"

        "Minecraft/.minecraft"
        "Multimc/.local/share/multimc"
        "Gradle/.gradle"
      ];
      files = [
        "Multimc/.config/MultiMC5rc"
      ];
    };


    home.persistence."/nix/dotfiles" = {         # synced dotfiles - shared with other computers
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "Atom/.atom"
        "Clementine/.config/Clementine"
        "Discord/.config/discord"
        "Firefox/.mozilla"
        "OpenTabletDriver/.config/OpenTabletDriver"

        "Keepassxc/.cache/keepassxc"
        "Keepassxc/.config/keepassxc"

        "Libreoffice/.config/libreoffice"

        "JetBrains/.cache/JetBrains"
        "JetBrains/.config/JetBrains"
        "JetBrains/.local/share/JetBrains"

        "VSCodium/.vscode-oss"
        "VSCodium/.config/VSCodium"
      ];
      files = [
      ];
    };


    home.persistence."/nix/dotfiles/Plasma" = {
      removePrefixDirectory = false;
      allowOther = true;
      directories = [
        ".config/gtk-3.0"
        ".config/gtk-4.0"
        ".config/KDE"
        ".config/kde.org"
        ".config/plasma-workspace"
        ".config/xsettingsd"
        ".kde"

        ".local/share/baloo"
        ".local/share/dolphin"
        ".local/share/kactivitymanagerd"
        ".local/share/kate"
        ".local/share/klipper"
        ".local/share/konsole"
        ".local/share/kscreen"
        ".local/share/kwalletd"
        ".local/share/kxmlgui5"
        ".local/share/plasma"
        ".local/share/RecentDocuments"
        ".local/share/sddm"
      ];
      files = [
        ".config/akregatorrc"
        ".config/baloofileinformationrc"
        ".config/baloofilerc"
        ".config/bluedevilglobalrc"
        ".config/device_automounter_kcmrc"
        ".config/dolphinrc"
        ".config/filetypesrc"
        ".config/gtkrc"
        ".config/gtkrc-2.0"
        ".config/gwenviewrc"
        ".config/kactivitymanagerd-pluginsrc"
        ".config/kactivitymanagerd-statsrc"
        ".config/kactivitymanagerd-switcher"
        ".config/kactivitymanagerdrc"
        ".config/katemetainfos"
        ".config/katerc"
        ".config/kateschemarc"
        ".config/katevirc"
        ".config/kcmfonts"
        ".config/kcminputrc"
        ".config/kconf_updaterc"
        ".config/kded5rc"
        ".config/kdeglobals"
        ".config/kgammarc"
        ".config/kglobalshortcutsrc"
        ".config/khotkeysrc"
        ".config/kmixrc"
        ".config/konsolerc"
        ".config/kscreenlockerrc"
        ".config/ksmserverrc"
        ".config/ksplashrc"
        ".config/ktimezonedrc"
        ".config/kwinrc"
        ".config/kwinrulesrc"
        ".config/kxkbrc"
        ".config/mimeapps.list"
        ".config/partitionmanagerrc"
        ".config/plasma-localerc"
        ".config/plasma-nm"
        ".config/plasma-org.kde.plasma.desktop-appletsrc"
        ".config/plasmanotifyrc"
        ".config/plasmarc"
        ".config/plasmashellrc"
        ".config/PlasmaUserFeedback"
        ".config/plasmawindowed-appletsrc"
        ".config/plasmawindowedrc"
        ".config/powermanagementprofilesrc"
        ".config/spectaclerc"
        ".config/startkderc"
        ".config/systemsettingsrc"
        ".config/touchpadxlibinputrc"
#         ".config/Trolltech.conf"
#         ".config/user-dirs.dirs"
        ".config/user-dirs.locale"

        ".local/share/krunnerstaterc"
        ".local/share/user-places.xbel"
        ".local/share/user-places.xbel.bak"
        ".local/share/user-places.xbel.tbcache"
      ];
    };


    home.stateVersion = "21.11";
  };




}
