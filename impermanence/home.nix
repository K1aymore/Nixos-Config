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

      neovim = {
        enable = true;
        vimAlias = true;
	      viAlias = true;
        vimdiffAlias = true;

        # coc.enable = true;
        # nerdtree vim-airline ultisnips
        plugins = with pkgs.vimPlugins; [ vim-nix tagbar indentLine vim-closer YouCompleteMe vim-surround haskell-vim vimproc ];

        extraConfig = ''
          syntax on
          set number
          set relativenumber

          set expandtab
          set tabstop=2
          set shiftwidth=2
          set softtabstop=2

          set splitright
          set splitbelow

          autocmd Filetype json
            \ let g:indentLine_setConceal = 0
        '';
      };

    };



    /* home.file = {
      ".bashrc".text = ''
        export PATH=”$PATH:$HOME/.emacs.d/bin”
      '';
    }; */


    home.persistence."/nix/persist/home" = {
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "Autostart/.config/autostart"
        "Pipewire/.local/state/pipewire"
        "Pipewire/.local/state/wireplumber"
        "Pipewire/.config/pulse"

        "Blender/.config/blender"

        "Element/.config/Element"
        "Element/.pki"
        "Discord/.config/discord"
        "Session/.config/Session"

        "Firefox/.mozilla"
        "SSH/.ssh"
        "Mullvad/.config/Mullvad VPN"
        "qBittorrent/.local/share/qBittorrent"
        "qBittorrent/.config/qBittorrent"
        "qBittorrent/.cache/qBittorrent"
        "BiglyBT/.biglybt"
        "Flood/.local/share/flood"


        "Minecraft/.minecraft"
        "Polymc/.local/share/polymc"
        "MultiMC/.local/share/multimc"
        "Gradle/.gradle"

        "Wine/.wine"
        "Grapejuice/.local/share/grapejuice"
        "PlayOnLinux/.PlayOnLinux"

        "Steam/.steam"
        "Steam/.local/share/Steam"

        "Exodus/.config/Exodus"
      ];
      files = [
        "Bash/.bash_history"
        "Polymc/.config/PolyMCrc"
      ];
    };


    home.persistence."/nix/dotfiles" = {
      removePrefixDirectory = true;
      allowOther = true;
      directories = [
        "OpenTabletDriver/.config/OpenTabletDriver"
        "Sway/.config/sway"

        "Tealdeer/.cache/tealdeer"
        "AWSCLI/.aws"
        "Rclone/.config/rclone"
        "GitHubCLI/.config/gh"
        "Git/.config/git"

        /* "Chromium/.cache/chromium"
        "Chromium/.config/chromium" */

        "Keepassxc/.cache/keepassxc"
        "Keepassxc/.config/keepassxc"
        "GPG/.gnupg"

        "OpenTTD/.config/openttd"
        "OpenTTD/.local/share/openttd"

        "Libreoffice/.config/libreoffice"

        "Atom/.atom"
        "Godot/.local/share/godot"
        "Godot/.cache/godot"
        "Godot/.config/godot"
        "JetBrains/.cache/JetBrains"
        "JetBrains/.config/JetBrains"
        "JetBrains/.local/share/JetBrains"
        "QtCreator/.cache/QtProject"
        "QtCreator/.config/QtProject"
        "VSCodium/.vscode-oss"
        "VSCodium/.config/VSCodium"

        "Emacs/.emacs.d"
        "Emacs/.doom.d"

        "Clementine/.config/Clementine"
        "Strawberry/.config/strawberry"
        "Strawberry/.cache/strawberry"
        "Strawberry/.local/share/strawberry"
        "VLC/.local/share/vlc"
        "VLC/.config/vlc"

        "Syncplay/.config/Syncplay"
      ];
      files = [
        "LMMS/.lmmsrc.xml"

        "Syncplay/.config/syncplay.ini"
        "Syncplay/.config/syncplayrc"
        "QtCreator/.config/QtProject.conf"
        "QtCreator/.config/QtCreatorrc"
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
        ".config/session"
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
