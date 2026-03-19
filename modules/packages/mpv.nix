{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.mpv.enable {

    home-manager.users.klaymore.programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped.overrideAttrs (old: {
        ffmpeg = pkgs.ffmpeg-full;
        version = "0.41.0-UNKNOWN";
        src = pkgs.fetchFromGitHub {
          owner = "mpv-player";
          repo = "mpv";
          rev = "cbecfb40465c854c7f7895eef6ba0c750e6a5c2e";
          hash = "sha256-Xn0rrKv2qOk0h02qZ3TMk4gnO7/hestIR6MdnsFzEvg=";
        };
      });
      config = {
        fullscreen = true;
        # fs-screen = 0; # screen numbers change sometimes
        # screen = 0;
        # autofit = "100%";
        # window-maximized = true;
        keep-open = false;
        autocreate-playlist = "same";
        audio-file-auto = "fuzzy";
        sub-auto = "fuzzy";
        # secondary-sid = 0; # mpvacious overrides anyway

        alang = "sv,en,de,fr,it,eo,tok";
        slang = "sv,en,fr,eo,tok";
        subs-with-matching-audio = "forced";
        # af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
        # af = "loudnorm=I=-20";
        volume-max = 200;
        hr-seek = true;
        replaygain = "track";
        blend-subtitles = "video";
        # sub-font-size = 49; # only for some subs (find out what)


        # best quality, except for 8K which is dumb
        ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";

        # dmabuf-wayland always uses source target-trc etc
        vo = "gpu-next";
        hwdec = "auto"; # Causes jitter and missed/delayed frames with display-resample
        gpu-api = "vulkan";
        gpu-context = "waylandvk";
        cache = true;
        vd-queue-enable = true; # laptop software AV1 decoding

        # https://artoriuz.github.io/blog/imagemagick_resampling.html
        profile = lib.mkIf config.klaymore.powerful "high-quality";
        scale = if config.klaymore.powerful then "ewa_lanczossharp" else "hermite";
        dscale = if config.klaymore.powerful then "ewa_lanczossharp" else "hermite"; # ewa_lanczossharp/lanczos > catmull_rom/mitchell/hermite > bilinear 
        dither = "fruit";
        deband = true;
        # deband-iterations = 4; # does nothing?
        # deband-range = 16; # does nothing?


        # SSimSuperRes causes jitter with display-resample(-vdrop)
        video-sync = "audio";
        interpolation = true;
        tscale = "oversample";


        # gamma2.2 darker than bt.1886
        # pq matches gamma2.2 on SDR displays and on HDR with clip / mobius / gamma tonemappers
        # works on EDR displays too but cranks screen brightness to max, worse blacks
        # should be PQ because mpv does dithering/debanding in HDR space, nicer (Sanda E01 00:41)
        # PQ flickers when OSD disappears, sometimes goes black when paused
        # PQ subtitles slightly too dark
        # gamma2.2 is too dark on the projector, hard to see (sometimes?). Default to bt.1886
        target-trc = if config.klaymore.gui.hdr then "gamma2.2" else "bt.1886";
        target-prim = "bt.709";
        treat-srgb-as-power22 = "both";
        target-colorspace-hint = "auto";

        # for HDR->SDR with bt.709 and bt.1886: bt.2446a darker & more contrasted. mobius more saturated. Reinhard = mobius but flatter and desaturated. Hable dark. bt.2390 like mobius but brighter and less saturation / bloom. gamma = bt.2390 but less blown out highlights. st2094-40 actually visible in dark, terrible colors and washed out shadows.
        # for HDR->SDR, for standard content < 203 nits, bt.2446a / reinhard / slightly hable wash out colors and brighten, not good
        # dark content < 80 nits, bt.2390 brightens slightly, good.

        # on SDR display: hable just linear but brighter, bad. bt.2390 more pop than linear, blown out, bad. bt.2446a washed out shadows, flatter, bad.

        # HDR->SDR bt.1886 on 3rd monitor with ICC profile, versus XV275K HDR 203 nits
        # HTTYD 54:38 full brightness/contrast
          # auto (spline): good dark shadows with details. Bright colors desaturated obvi, high mids (horizon) little too bright
          # bt.2446a: shadows raised, high mids still too bright
          # mobius: highlights way too blown out, clouds desaturated as hell
          # reinhard: mobius but worse
          # hable: shadows slightly lifted, horizon/clouds too bright still
          # bt.2390: very bright. Highlight really fricking glowing. Shadows slighhtly raised
          # gamma: shadows decent. Highlight alright but high mids still pretty bright
          # linear: good hangling of highlight and pretty good high mids (still too bright). Shadows kinda washed out
          # st.2094-40: shadows raised, way too blown out
          # hable (vs spline): darker high-mids, brighter shadows
          # gamma (vs auto): brighter high-mids, darker shadows
          # linear (vs auto): flatter. Darker highlight / brigher shadows
        # HTTYD 32:36 brightness 100% contrast 75%
          # auto: slightly raised shadows, too bright overall. Face slightly desaturated
          # mobius: just spline with -2 brightness and +6 saturation, except highlights barely brighter
          # gamma: exact same as mobius
          # bt.2390: darker, less contrast than spline
          # bt2446a / reinhard / hable / st.2094-40 / linear too washed out, suck
        
        # Literally just run as pq (or bt.1886) with auto (spline). bt.1886 brighter.

        # don't use pq on sdr display, issues with scene detection etc
        # With gamma2.2, need either mobius, gamma, or maybe bt.2390 for alright shadows. Others washed out.
        tone-mapping = "auto";
      };


      profiles = {
        HDR = lib.mkIf config.klaymore.gui.hdr {
          profile-cond = ''video_params and p["video-params/primaries"] == "bt.2020"'';
          profile-restore = "copy";

          target-trc = "pq";
          target-prim = "bt.2020";
        };

        forced = {
          profile-cond = ''p["current-tracks/sub/forced"]'';
          profile-restore = "copy";

          blend-subtitles = "video";
        };
      };

      # test with mpv --input-test --force-window --idle
      bindings = {
        "CTRL+`" = "cycle blend-subtitles";
        "CTRL+1" = "cycle-values dscale bilinear hermite mitchell catmull_rom lanczos ewa_lanczossharp";
        "CTRL+2" = "cycle-values scale bilinear hermite mitchell catmull_rom lanczos ewa_lanczossharp";
        "CTRL+3" = "cycle target-colorspace-hint";

        "CTRL+4" = "cycle-values target-prim auto bt.2020 bt.709";
        "CTRL+5" = "cycle-values target-trc auto pq gamma2.2 bt.1886";
        "CTRL+6" = "cycle-values tone-mapping auto bt.2446a mobius reinhard hable bt.2390 gamma linear st2094-40";

        "CTRL+7" = "cycle-values video-sync display-resample-vdrop audio";
        "CTRL+8" = "cycle-values vo gpu gpu-next dmabuf-wayland";

        # https://www.reddit.com/r/NixOS/comments/191wg98/using_a_directory_from_a_git_repo_as_source_for_a/
        "CTRL+9" = "no-osd change-list glsl-shaders set \"${./mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
        "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";

        "CTRL+i" = "cycle interpolation";

        # https://github.com/mpv-player/mpv/issues/8413
        #"c" = "vf toggle crop=[if(lte(iw/16,ih/9),iw,ih/9*16)]:[if(lte(iw/16,ih/9),iw/16*9,ih)]"; # crop to 16:9
        "c" = "vf toggle crop=in_w:in_w/1.78";
        "C" = "vf toggle crop=in_w:in_w/2.38";

        "CTRL+v" = "af toggle dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
        #"CTRL+b" = "af toggle earwax";
        #"CTRL+n" = "af toggle loudnorm=I=-20";
        "CTRL+m" = "cycle-values audio-channels stereo mono auto-safe"; # toggle mono audio

        "CTRL+WHEEL_UP" = "add target-peak 25";
        "CTRL+WHEEL_DOWN" = "add target-peak -25";

        "CTRL+_" = "add audio-delay -0.100";
        "CTRL++" = "add audio-delay 0.100";

        "CTRL+-" = "add video-scale-x -0.01; add video-scale-y -0.01";
        "CTRL+=" = "add video-scale-x 0.01; add video-scale-y 0.01";

        "CTRL+s" = "cycle secondary-sid";
        "CTRL+S" = "cycle secondary-sid down";

        # "a" = "vf toggle hflip";
        "b" = "cycle deband";

        "HOME" = "seek 0 absolute";
      };

      scriptOpts.osc = {
        # bring back original controls
        # ''no-osd cycle audio; show-text "''${!current-tracks/audio/id:Audio: no}''${?current-tracks/audio/id:Audio: (''${current-tracks/audio/id}) ''${current-tracks/audio/title:} (''${current-tracks/audio/lang:}) [''${current-tracks/audio/codec}}]"''
        audio_track_mbtn_left_command = "cycle audio";
        audio_track_mbtn_mid_command = "script-binding select/select-aid; script-message-to osc osc-hide";
        audio_track_mbtn_right_command = "cycle audio down";
        sub_track_mbtn_left_command = "cycle sub";
        sub_track_mbtn_mid_command = "script-binding select/select-sid; script-message-to osc osc-hide";
        sub_track_mbtn_right_command = "cycle sub down";
      };

      scripts = [
        #pkgs.mpvScripts.autocrop
        #pkgs.mpvScripts.mpvacious
      ];
    };

    # Used to be for copying shaders to config path, now instead use /nix/store path
    # home-manager.users.klaymore.home.file.".config/mpv" = {
    #   enable = true;
    #   recursive = true;
    #   source = ./-mpvShaders;
    # };
  };
}
