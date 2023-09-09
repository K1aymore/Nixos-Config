{ home-manager, impermanence, ... }:


{

  imports = [
    home-manager.nixosModule
    #impermanence.nixosModules.home-manager.impermanence
  ];

  programs.fuse.userAllowOther = true;


  home-manager.users.klaymore = {
    home.homeDirectory = "/home/klaymore";

    imports = [ "${impermanence}/home-manager.nix" ];

    programs.home-manager.enable = true;

    home.file = {
      # export PATH=”$PATH:/synced/Sync/Linux/BashScripts”  # this breaks sudo
      ".bashrc".text = ''
        export GPG_TTY=$(tty)
      '';
    };


    home.persistence."/synced/Nix/persist/home" = {
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "Autostart/.config/autostart"
        "Pipewire/.local/state/pipewire"
        "Pipewire/.local/state/wireplumber"
        "Pipewire/.config/pulse"
        "Elvish/.local/state/elvish"
        "Zoxide/.local/share/zoxide"

        "Blender/.config/blender"
        "DaVinci/.local/share/DaVinciResolve"
        "DaVinci/Documents/BlackmagicDesign"
        "NixifiedAI/invokeai"

        "VSCode/.vscode"
        "VSCode/.config/Code"
        "Lapce/.local/share/lapce-nightly"

        "Godot/.local/share/godot"
        "Godot/.cache/godot"

        "Discord/.config/discord"

        "Element/.config/Element"
        "Element/.pki"
        "Session/.config/Session"

        "Edge/.config/microsoft-edge"
        "Firefox/.mozilla"
        "Librewolf/.librewolf"
        "SSH/.ssh"
        "Mullvad/.config/Mullvad VPN"
        "qBittorrent/.local/share/qBittorrent"
        "qBittorrent/.config/qBittorrent"
        "qBittorrent/.cache/qBittorrent"
        "BiglyBT/.biglybt"
        "Flood/.local/share/flood"

        "Android/.android"
        "Android/Android"

        "Minecraft/.minecraft"
        "Prism/.local/share/PrismLauncher"
        "Polymc/.local/share/polymc"
        "MultiMC/.local/share/multimc"
        "Gradle/.gradle"

        "Wine/.wine"
        "Grapejuice/.local/var/log/grapejuice"
        "Grapejuice/.local/share/grapejuice"
        "Grapejuice/.config/brinkervii"
        "PlayOnLinux/.PlayOnLinux"
        "Lutris/.config/lutris"
        "Lutris/.local/share/lutris"
        "Heroic/.config/legendary"
        "Heroic/.config/heroic"
        "Games/Games"
        "Games/My Games"
        "Bottles/.local/share/bottles"

        "Flatpak/.local/share/flatpak"
        "Flatpak/.var"
        "Steam/.steam"
        "Steam/.local/share/Steam"
        "Itch.io/.itch"
        "Itch.io/.config/itch"
        "Cargo/.cargo"

        "Exodus/.config/Exodus"
        #"Pmbootstrap/.local/var/pmbootstrap"

        "Python/.cache/pip"

        "Baloo/.local/share/baloo"

        "Nix/.cache/nix"
      ];
      files = [
        "Bash/.bash_history"
        "Polymc/.config/PolyMCrc"
        "Baloo/.config/baloofileinformationrc"
        "Baloo/.config/baloofilerc"
      ];
    };


    home.persistence."/synced/Nix/dotfiles" = {
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "OpenTabletDriver/.config/OpenTabletDriver"

        "Tealdeer/.cache/tealdeer"
        "AWSCLI/.aws"
        "Rclone/.config/rclone"
        "GitHubCLI/.config/gh"
        #"Git/.config/git"

        /* "Chromium/.cache/chromium"
        "Chromium/.config/chromium"*/

        "Keepassxc/.cache/keepassxc"
        "Keepassxc/.config/keepassxc"
        "GPG/.gnupg"

        "OpenTTD/.config/openttd"
        "OpenTTD/.local/share/openttd"
        "OpenDungeons/.config/opendungeons"
        "OpenDungeons/.local/share/opendungeons"
        "Crawl/.crawl"

        "JOSM/.config/JOSM"
        "JOSM/.local/share/JOSM"

        "Libreoffice/.config/libreoffice"
        "DigiKam/.local/share/digikam"
        "DigiKam/.cache/digikam"
        "OBS/.config/obs-studio"

        "Atom/.atom"
        "Godot/.config/godot"
        "JetBrains/.cache/JetBrains"
        "JetBrains/.config/JetBrains"
        "JetBrains/.local/share/JetBrains"
        "QtCreator/.cache/QtProject"
        "QtCreator/.config/QtProject"
        "Chromium/.cache/chromium"
        "Chromium/.config/chromium"
        "Lagrange/.config/lagrange"

        "Ardour/.config/ardour6"

        "Lapce/.config/lapce-nightly"
        "Emacs/.emacs.d"
        "Emacs/.doom.d"
        "Elinks/.elinks"

        "Clementine/.config/Clementine"
        "Strawberry/.config/strawberry"
        "Strawberry/.cache/strawberry"
        "Strawberry/.local/share/strawberry"
        "VLC/.local/share/vlc"
        "VLC/.config/vlc"

        "Pixelorama/.local/share/pixelorama"
        "Musescore/.local/share/Musescore"
        "Musescore/.config/Musescore"

        "Syncplay/.config/Syncplay"
      ];
      files = [
        "LMMS/.lmmsrc.xml"

        "Syncplay/.config/syncplay.ini"
        "Syncplay/.config/syncplayrc"
        "QtCreator/.config/QtProject.conf"
        "QtCreator/.config/QtCreatorrc"

        "DigiKam/.config/digikamrc"
      ];
    };


    home.persistence."/synced/Nix/dotfiles/Plasma" = {
      removePrefixDirectory = false;
      allowOther = true;
      directories = [
        ".config/gtk-3.0"
        ".config/gtk-4.0"
        ".config/KDE"
        ".config/kde.org"
        ".config/plasma-workspace"
        ".config/session"
        ".config/xsettingsd"
        ".kde"

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


    home.stateVersion = "22.11";
  };




}
