{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.mpd.enable {

    environment.systemPackages = with pkgs; [
      cava
    ];


    services.mpd = {
      enable = true;
      startWhenNeeded = false;
      user = "klaymore";
      group = "users";
      settings = rec {
        music_directory = "/synced/Media/Music";
        playlist_directory = music_directory;
      };
    };

    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
      XDG_RUNTIME_DIR = "/run/user/1000";
    };

    services.mpdscribble = {
      enable = true;
      endpoints."last.fm" = {
        username = "K1aymore";
        passwordFile = "${config.klaymore.configPath}/_secrets/mpdscribbleLastfm";
      };
    };


    home-manager.users.klaymore.programs.ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };
      settings = {
        mpd_host = "localhost";
        mpd_port = "6600";

        ignore_leading_the = "yes";
        mouse_support = "yes";

        playlist_display_mode = "columns";
        progressbar_look = "-⊳";
        user_interface = "alternative";
        header_visibility = "no";
        titles_visibility = "no";

        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_in_stereo = "yes";
        visualizer_type = "ellipse";
        visualizer_look = "+|";
      };
    };

    home-manager.users.klaymore.programs.rmpc = {
      enable = true;
      config = ''
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    address: "127.0.0.1:6600",
    password: None,
    theme: Some("catppuccin"),
    cache_dir: None,
    on_song_change: None,
    volume_step: 5,
    max_fps: 30,
    scrolloff: 999,
    wrap_navigation: false,
    enable_mouse: true,
    enable_config_hot_reload: true,
    status_update_interval_ms: 1000,
    rewind_to_start_sec: Some(10),
    reflect_changes_to_playlist: false,
    select_current_song_on_change: false,
    browser_song_sort: [Disc, Track, Artist, Title],
    directories_sort: SortFormat(group_by_type: true, reverse: false),
    album_art: (
        method: Auto,
        max_size_px: (width: 1200, height: 1200),
        disabled_protocols: ["http://", "https://"],
        vertical_align: Top,
        horizontal_align: Center,
    ),
    keybinds: (
        global: {
            ":":       CommandMode,
            ",":       VolumeDown,
            ".":       VolumeUp,
            "9":       VolumeDown,
            "0":       VolumeUp,
            "s":       Stop,
            "<Tab>":   NextTab,
            "<S-Tab>": PreviousTab,
            "1":       SwitchToTab("Queue"),
            "2":       SwitchToTab("Directories"),
            "3":       SwitchToTab("Artists"),
            "4":       SwitchToTab("Album Artists"),
            "5":       SwitchToTab("Albums"),
            "6":       SwitchToTab("Playlists"),
            "7":       SwitchToTab("Search"),
            "q":       Quit,
            ">":       NextTrack,
            "<":       PreviousTrack,
            "p":       TogglePause,
            "b":       SeekBack,
            "f":       SeekForward,
            "z":       ToggleRepeat,
            "x":       ToggleRandom,
            "c":       ToggleConsume,
            "v":       ToggleSingle,
            "~":       ShowHelp,
            "u":       Update,
            "U":       Rescan,
            "I":       ShowCurrentSongInfo,
            "O":       ShowOutputs,
            "P":       ShowDecoders,
            "R":       AddRandom,
        },
        navigation: {
            "k":         Up,
            "j":         Down,
            "h":         Left,
            "l":         Right,
            "<Up>":      Up,
            "<Down>":    Down,
            "<Left>":    Left,
            "<Right>":   Right,
            "<C-k>":     PaneUp,
            "<C-j>":     PaneDown,
            "<C-h>":     PaneLeft,
            "<C-l>":     PaneRight,
            "<PageUp>":     UpHalf,
            "<PageDown>":   DownHalf,
            "K":         MoveUp,
            "J":         MoveDown,
            "g":         Top,
            "G":         Bottom,
            "<Home>":    Top,
            "<End>":     Bottom,
            "n":         NextResult,
            "N":         PreviousResult,
            "i":         FocusInput,
            "/":         EnterSearch,
            "a":         Add,
            "A":         AddAll,
            "D":         Delete,
            "r":         Rename,
            "<Space>":   Select,
            "<C-Space>": InvertSelection,
            "<CR>":      Confirm,
            "<C-c>":     Close,
            "<Esc>":     Close,
            "B":         ShowInfo,
        },
        queue: {
            "<CR>":    Play,
            "<C-s>":   Save,
            "a":       AddToPlaylist,
            "d":       Delete,
            "D":       DeleteAll,
            "C":       JumpToCurrent,
            "X":       Shuffle,
        },
    ),
    search: (
        case_sensitive: false,
        mode: Contains,
        tags: [
            (value: "any",         label: "Any Tag"),
            (value: "artist",      label: "Artist"),
            (value: "album",       label: "Album"),
            (value: "albumartist", label: "Album Artist"),
            (value: "title",       label: "Title"),
            (value: "filename",    label: "Filename"),
            (value: "genre",       label: "Genre"),
        ],
    ),
    artists: (
        album_display_mode: SplitByDate,
        album_sort_by: Date,
    ),
    tabs: [
        (
            name: "Queue",
            pane: Split(
                direction: Horizontal,
                panes: [(size: "40%", pane: Pane(AlbumArt)), (size: "60%", pane: Pane(Queue))],
            ),
        ),
        (
            name: "Directories",
            pane: Pane(Directories),
        ),
        (
            name: "Artists",
            pane: Pane(Artists),
        ),
        (
            name: "Album Artists",
            pane: Pane(AlbumArtists),
        ),
        (
            name: "Albums",
            pane: Pane(Albums),
        ),
        (
            name: "Playlists",
            pane: Pane(Playlists),
        ),
        (
            name: "Search",
            pane: Pane(Search),
        ),
    ],
),
cava: (
    framerate: 30, // default 60
    autosens: true, // default true
    sensitivity: 100, // default 100
    lower_cutoff_freq: 50, // not passed to cava if not provided
    higher_cutoff_freq: 10000, // not passed to cava if not provided
    input: (
        method: Fifo,
        source: "/tmp/mpd.fifo",
        sample_rate: 44100,
        channels: 2,
        sample_bits: 16,
    ),
    smoothing: (
        noise_reduction: 77, // default 77
        monstercat: false, // default false
        waves: false, // default false
    ),
    // this is a list of floating point numbers thats directly passed to cava
    // they are passed in order that they are defined
    eq: []
)'';
    };

    home-manager.users.klaymore.home.file.".config/rmpc/themes/catppuccin.ron".text = ''
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    draw_borders: false,
    show_song_table_header: false,
    symbols: (song: "🎵", dir: "📁", playlist: "🎼", marker: "\u{e0b0}"),
    progress_bar: (
        symbols: ["", "", "⭘", " ", " "],
        track_style: (bg: "#181825"),
        elapsed_style: (fg: "#eba0ac", bg: "#181825"),
        thumb_style: (fg: "#eba0ac", bg: "#181825"),
    ),
    scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (),
        ends_style: (),
        thumb_style: (fg: "#b4befe"),
    ),
    browser_column_widths: [20, 38, 42],
    text_color: "#cdd6f4",
    background_color: "#1e1e2e",
    header_background_color: "#181825",
    modal_background_color: None,
    modal_backdrop: false,
    tab_bar: (active_style: (fg: "black", bg: "#eba0ac", modifiers: "Bold"), inactive_style: ()),
    borders_style: (fg: "#6c7086"),
    highlighted_item_style: (fg: "#eba0ac", modifiers: "Bold"),
    current_item_style: (fg: "black", bg: "#b4befe", modifiers: "Bold"),
    highlight_border_style: (fg: "#b4befe"),
    song_table_format: [
        (
            prop: (kind: Property(Artist), style: (fg: "#b4befe"),
                default: (kind: Text("Unknown"))
            ),
            width: "25%",
        ),
        (
            prop: (kind: Property(Title), style: (fg: "#74c7ec"),
                default: (kind: Text("Unknown"))
            ),
            width: "35%",
        ),
        (
            prop: (kind: Property(Album), style: (fg: "white"),
                default: (kind: Text("Unknown Album"), style: (fg: "white"))
            ),
            width: "30%",
        ),
        (
            prop: (kind: Property(Duration),
                default: (kind: Text("-"))
            ),
            width: "10%",
            alignment: Right,
        ),
    ],
    header: (
        rows: [
            (
                left: [
                    (kind: Text("["), style: (fg: "#b4befe", modifiers: "Bold")),
                    (kind: Property(Status(State)), style: (fg: "#b4befe", modifiers: "Bold")),
                    (kind: Text("]"), style: (fg: "#b4befe", modifiers: "Bold"))
                ],
                center: [
                    (kind: Property(Song(Artist)), style: (fg: "#f9e2af", modifiers: "Bold"),
                        default: (kind: Text("Unknown"), style: (fg: "#f9e2af", modifiers: "Bold"))
                    ),
                    (kind: Text(" - ")),
                    (kind: Property(Song(Title)), style: (fg: "#74c7ec", modifiers: "Bold"),
                        default: (kind: Text("No Song"), style: (fg: "#74c7ec", modifiers: "Bold"))
                    ),
                    (kind: Text(" - ")),
                    (kind: Property(Song(Album)), style: (fg: "#74c7ec"),
                        default: (kind: Text("Unknown Album"))
                    )
                ],
                right: [
                    (kind: Property(Widget(States(
                            active_style: (fg: "white", modifiers: "Bold"),
                            separator_style: (fg: "white")))
                        ),
                        style: (fg: "dark_gray")
                    ),
                    (kind: Text("  ")),
                    (kind: Text("Vol: "), style: (fg: "#b4befe", modifiers: "Bold")),
                    (kind: Property(Status(Volume)), style: (fg: "#b4befe", modifiers: "Bold")),
                    (kind: Text("% "), style: (fg: "#b4befe", modifiers: "Bold"))
                ]
            )
        ],
    ),
)'';

  };
}