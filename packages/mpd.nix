{ pkgs, ... }:

{

  services.mpd = rec {
    enable = true;
    musicDirectory = "/synced/Media/Music";
    playlistDirectory = musicDirectory;
    startWhenNeeded = true;
    user = "klaymore";
    group = "users";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
      audio_output {
        type                    "fifo"
        name                    "my_fifo"
        path                    "/tmp/mpd.fifo"
        format                  "44100:16:2"
      }
      audio_buffer_size "512"
    '';
  };

  systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  services.mpdscribble = {
    enable = true;
    endpoints."last.fm" = {
      username = "K1aymore";
      passwordFile = "";
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

}
