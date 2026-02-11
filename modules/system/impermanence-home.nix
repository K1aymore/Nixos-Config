{ config, lib, ... }:

{
  config = let
    getPrefixName = s: builtins.elemAt (lib.splitString "/" s) 0;
    getWithoutPrefix = s: lib.removePrefix ((getPrefixName s) + "/") s;

    # takes list of files or directories as strings
    # returns attrset where names are prefix and values are list of home paths
    extractPrefixes = dirs: builtins.mapAttrs (prefix: path:
      map (p: getWithoutPrefix p) path
    ) (builtins.groupBy getPrefixName dirs);


    # takes two args, dirs and files as lists of strings "prefix/homePath"
    # returns attrset where each element is
    #   "prefix" = {
    #     dirs = [ "homePath" ];
    #     files = [ "homePath" ];
    groupByPrefix = dirs: files: let
      dirPrefixes = builtins.attrNames (extractPrefixes dirs);
      filePrefixes = builtins.attrNames (extractPrefixes files);
      prefixes = lib.lists.unique (dirPrefixes ++ filePrefixes);
    in lib.mergeAttrsList (map (prefix:
    {
      ${prefix} = {
        dirs = (extractPrefixes dirs).${prefix} or [];
        files = (extractPrefixes files).${prefix} or [];
      };
    }) prefixes);


    # return attrset for output
    genOutDir = sourcePath: prefixedDir: let
      prefix = getPrefixName prefixedDir;
      homePath = getWithoutPrefix prefixedDir;
    in  {
      fileSystems.${"/home/klaymore/" + homePath} = {
        device = sourcePath + "/" + prefix + "/" + homePath;
        fsType = "none";
        options = [ "bind" "noatime" ];
      };
    };

    # return attrset for output
    genOutFile = sourcePath: prefixedFile: let
      prefix = getPrefixName prefixedFile;
      homePath = getWithoutPrefix prefixedFile;
    in {
      home-manager.users.klaymore = { config, ... }: {
        home.file.${homePath}.source = config.lib.file.mkOutOfStoreSymlink (sourcePath + "/" + prefix + "/" + homePath);
      };
    };


    # take single source path with lists of dirs and files
    # return attrsets with prefixes for output
    genOutsForSource = sourcePath: {dirs, files}: lib.mergeAttrsList (
      map (genOutDir sourcePath) dirs ++ map (genOutFile sourcePath) files
    );


    # take attrset where each element is
    #   "sourcePath" = {
    #     dirs = [ "" ]
    #     files = [ "" ]
    # return attrsets
    #   "source/prefix" = {
    #     hideMounts = true;
    #     directories = [ "" ];
    #     files = [ "" ];
    removePrefixDirs = d: lib.concatMapAttrs genOutsForSource d;

  in lib.mkIf config.klaymore.system.impermanence.home.enable (removePrefixDirs {
    "/synced/Nix/persist/home" = {
      dirs = [
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
        "VSCodium/.vscode-oss"
        "VSCodium/.config/VSCodium"
        "Lapce/.config/lapce-nightly"
        "Lapce/.local/share/lapce-nightly"

        "Godot/.local/share/godot"
        "Godot/.cache/godot"
        "Unity/.config/unityhub"
        "Unity/.config/unity3d"
        "Unity/Unity"

        "Discord/.config/discord"
        "BetterDiscord/.config/BetterDiscord"

        "Element/.config/Element"
        "Element/.pki"
        "Session/.config/Session"

        "Edge/.config/microsoft-edge"
        "Firefox/.mozilla"
        "Librewolf/.librewolf"
        "Chromium/.cache/chromium"
        "Chromium/.config/chromium"
        "SSH/.ssh"
        "Mullvad/.config/Mullvad VPN"
        "qBittorrent/.local/share/qBittorrent"
        "qBittorrent/.config/qBittorrent"
        "qBittorrent/.cache/qBittorrent"
        "BiglyBT/.biglybt"
        "Flood/.local/share/flood"

        "Android/.android"
        "Android/Android"
        
        "JamesDSP/.cache/jamesdsp/"
        "RazerGenie/.local/share/razergenie"

        "Steam/.steam"
        "Steam/.local/share/Steam"

        "Flatpak/.local/share/flatpak"
        #"Flatpak/.var/app"

        "Cargo/.cargo"
        "Rustup/.rustup"

        "Exodus/.config/Exodus"
        #"Pmbootstrap/.local/var/pmbootstrap"

        "Cache/.cache"

        "Baloo/.local/share/baloo"

        "Python/.cache/pip"
        "Nix/.cache/nix"


        "Plasma/.config/gtk-3.0"
        "Plasma/.config/gtk-4.0"
        "Plasma/.config/KDE"
        "Plasma/.config/kde.org"
        "Plasma/.config/kdeconnect"
        "Plasma/.config/kdedefaults"
        "Plasma/.config/plasma-workspace"
        "Plasma/.config/session"
        "Plasma/.config/xsettingsd"
        "Plasma/.kde"

        "Plasma/.local/share/dolphin"
        "Plasma/.local/share/kactivitymanagerd"
        "Plasma/.local/share/kate"
        "Plasma/.local/share/klipper"
        "Plasma/.local/share/konsole"
        "Plasma/.local/share/kscreen"
        "Plasma/.local/share/kwalletd"
        "Plasma/.local/share/kxmlgui5"
        "Plasma/.local/share/plasma"
        "Plasma/.local/share/plasmashell"
        "Plasma/.local/share/RecentDocuments"
        "Plasma/.local/share/sddm"
      ];
      files = [
        "Bash/.bash_history"
        "Polymc/.config/PolyMCrc"
        "Baloo/.config/baloofileinformationrc"
        "Baloo/.config/baloofilerc"
        
        "JamesDSP/.config/jamesdsp/audio.conf"
        "JamesDSP/.config/jamesdsp/application.conf"
        "JamesDSP/.config/jamesdsp/graphiceq.conf"


        "Plasma/.config/akregatorrc"
        "Plasma/.config/bluedevilglobalrc"
        "Plasma/.config/device_automounter_kcmrc"
        "Plasma/.config/dolphinrc"
        "Plasma/.config/filetypesrc"
        "Plasma/.config/gtkrc"
        "Plasma/.config/gtkrc-2.0"
        "Plasma/.config/gwenviewrc"
        "Plasma/.config/kactivitymanagerd-pluginsrc"
        "Plasma/.config/kactivitymanagerd-statsrc"
        "Plasma/.config/kactivitymanagerd-switcher"
        "Plasma/.config/kactivitymanagerdrc"
        "Plasma/.config/katemetainfos"
        "Plasma/.config/katerc"
        "Plasma/.config/kateschemarc"
        "Plasma/.config/katevirc"
        "Plasma/.config/kcmfonts"
        "Plasma/.config/kcminputrc"
        "Plasma/.config/kconf_updaterc"
        "Plasma/.config/kded5rc"
        "Plasma/.config/kdeglobals"
        "Plasma/.config/kgammarc"
        "Plasma/.config/kglobalshortcutsrc"
        "Plasma/.config/khotkeysrc"
        "Plasma/.config/kmixrc"
        "Plasma/.config/konsolerc"
        "Plasma/.config/kscreenlockerrc"
        "Plasma/.config/ksmserverrc"
        "Plasma/.config/ksplashrc"
        "Plasma/.config/ktimezonedrc"
        "Plasma/.config/kwalletrc"
        "Plasma/.config/kwinoutputconfig.json"
        "Plasma/.config/kwinrc"
        "Plasma/.config/kwinrulesrc"
        "Plasma/.config/kxkbrc"
        "Plasma/.config/mimeapps.list"
        "Plasma/.config/partitionmanagerrc"
        "Plasma/.config/plasma-localerc"
        "Plasma/.config/plasma-nm"
        "Plasma/.config/plasma-org.kde.plasma.desktop-appletsrc"
        "Plasma/.config/plasmanotifyrc"
        "Plasma/.config/plasmarc"
        "Plasma/.config/plasmashellrc"
        "Plasma/.config/PlasmaUserFeedback"
        "Plasma/.config/plasmawindowed-appletsrc"
        "Plasma/.config/plasmawindowedrc"
        "Plasma/.config/powermanagementprofilesrc"
        "Plasma/.config/spectaclerc"
        "Plasma/.config/startkderc"
        "Plasma/.config/systemsettingsrc"
        "Plasma/.config/touchpadxlibinputrc"
        # "Plasma/.config/Trolltech.conf"
        # "Plasma/.config/user-dirs.dirs"
        "Plasma/.config/user-dirs.locale"

        "Plasma/.local/share/krunnerstaterc"
        "Plasma/.local/share/user-places.xbel"
        "Plasma/.local/share/user-places.xbel.bak"
        "Plasma/.local/share/user-places.xbel.tbcache"
      ];
    };

    "/synced/Nix/dotfiles" = {
      dirs = [
        "Wallpapers/.local/share/wallpapers"
        "OpenTabletDriver/.config/OpenTabletDriver"

        "Tealdeer/.cache/tealdeer"
        "AWSCLI/.aws"
        "Rclone/.config/rclone"
        "GitHubCLI/.config/gh"
        #"Git/.config/git"

        #"Chromium/.cache/chromium"
        #"Chromium/.config/chromium"

        "Keepassxc/.cache/keepassxc"
        "Keepassxc/.config/keepassxc"
        "GPG/.gnupg"


        "JOSM/.config/JOSM"
        "JOSM/.local/share/JOSM"
        
        "JamesDSP/.config/jamesdsp/irs"
        "JamesDSP/.config/jamesdsp/irs_favorites"
        "JamesDSP/.config/jamesdsp/liveprog"
        "JamesDSP/.config/jamesdsp/presets"
        "JamesDSP/.config/jamesdsp/vdc"


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
        "Lagrange/.config/lagrange"
        "Lapce/.config/lapce-stable"
        "Lapce/.local/share/lapce-stable"

        "Ardour/.config/ardour6"

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

    "/synced/Nix/games" = {
      dirs = [
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
        "Itch.io/.itch"
        "Itch.io/.config/itch"

        "DwarfFortress/.local/share/df_linux"
        "OpenTTD/.config/openttd"
        "OpenTTD/.local/share/openttd"
        "OpenDungeons/.config/opendungeons"
        "OpenDungeons/.local/share/opendungeons"
        "Crawl/.crawl"

        "Minecraft/.minecraft"
        "Prism/.local/share/PrismLauncher"
        "Gradle/.gradle"
      ];
      files = [];
    };

  });
}
