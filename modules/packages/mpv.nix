{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.programs.mpv.enable {

    home-manager.users.klaymore.programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped.overrideAttrs (old: {
        ffmpeg = pkgs.ffmpeg-full;
        version = "0.41.0";
        src = pkgs.fetchFromGitHub {
          owner = "mpv-player";
          repo = "mpv";
          tag = "v0.41.0";
          hash = "sha256-gJWqfvPE6xOKlgj2MzZgXiyOKxksJlY/tL6T/BeG19c=";
        };
        patches = [ ];
        mesonFlags = [
          (lib.mesonOption "default_library" "shared")
          (lib.mesonBool "libmpv" true)
          (lib.mesonEnable "manpage-build" true)
          (lib.mesonEnable "cdda" false)
          (lib.mesonEnable "dvbin" true)
          (lib.mesonEnable "dvdnav" true)
          (lib.mesonEnable "openal" true)
        ];
      });
      config = lib.mkMerge [ {
        fullscreen = true;
        # fs-screen = 0; # screen numbers change sometimes
        # screen = 0;
        # autofit = "100%";
        # window-maximized = true;
        keep-open = false;
        autocreate-playlist = "same";

        alang = "sv,en,de,fr,it,eo,tok";
        slang = "sv,en,fr,eo,tok";
        subs-with-matching-audio = "forced";
        # af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
        # af = "loudnorm=I=-20";
        volume-max = 200;
        hr-seek = true;


        # best quality, except for 8K which is dumb
        ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";

        # dmabuf-wayland always uses source target-trc etc
        vo = "gpu-next";
        hwdec = "auto"; # Causes jitter and missed/delayed frames with display-resample
        gpu-api = "vulkan";
        gpu-context = "waylandvk";

        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        dscale = "mitchell";
        deband = true;
        # deband-iterations = 4; # does nothing?
        # deband-range = 16; # does nothing?
        #blend-subtitles = "video";  # cool for signs but terrible for actual subs

        # affects HDR->SDR, and HDR when very bright
        # in HDR, spline/auto preserves details better, bt.2446a becomes spline when target-peak > 2400
        # for HDR->SDR, bt.2446a darker & more contrasted
        #tone-mapping = "bt.2446a";

        # SSimSuperRes causes jitter with display-resample(-vdrop)
        video-sync = "audio";
        interpolation = true;
        tscale = "oversample";


        # gamma2.2 darker/contraster than bt.1886
        # pq matches gamma2.2 on SDR displays and on HDR with clip / mobius / gamma tonemappers
        # works on EDR displays too but cranks screen brightness to max, worse blacks
        # should be PQ because mpv does dithering/debanding in HDR space, nicer (Sanda E01 00:41)
        target-trc = "pq";  # gamma2.2
        target-prim = "bt.2020";  # bt.709
        tone-mapping = "mobius";
        treat-srgb-as-power22 = "both";


        # needs to be on/auto for HDR in HDR
        # makes no difference when outputting bt.1886 in SDR
        # outputs pq if display is HDR or has brightness lowered, otherwise bt.1886
        target-colorspace-hint = "auto";
      }
      (lib.mkIf config.klaymore.powerful {
        # No visible difference but what the hey
        scale = lib.mkForce "ewa_lanczos4sharpest";
      })
      ];


      profiles = {
        # HDR = {
        #   profile-cond = ''video_params and p["video-params/primaries"] == "bt.2020"'';
        #   profile-restore = "copy";

        #   target-trc = "pq";
        #   target-prim = "bt.2020";
        # };

        forced = {
          profile-cond = ''p["current-tracks/sub/forced"]'';
          profile-restore = "copy";

          blend-subtitles = "video";
        };
      };

      # test with mpv --input-test --force-window --idle
      bindings = {
        "CTRL+`" = "cycle-values target-peak auto 500";
        "CTRL+1" = "cycle tone-mapping";
        "CTRL+2" = "cycle inverse-tone-mapping";
        "CTRL+3" = "cycle target-colorspace-hint";

        "CTRL+4" = "cycle-values target-prim auto bt.2020 bt.709";
        "CTRL+5" = "cycle-values target-trc auto pq bt.1886 gamma2.2";
        "CTRL+6" = "cycle-values tone-mapping auto bt.2446a st2094-40 mobius hable";

        "CTRL+7" = "cycle-values video-sync display-resample-vdrop audio";
        "CTRL+8" = "cycle-values vo gpu gpu-next dmabuf-wayland";

        # https://www.reddit.com/r/NixOS/comments/191wg98/using_a_directory_from_a_git_repo_as_source_for_a/
        "CTRL+9" = "no-osd change-list glsl-shaders set \"${./mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
        "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";

        "CTRL+i" = "cycle interpolation";

        # https://github.com/mpv-player/mpv/issues/8413
        #"c" = "vf toggle crop=[if(lte(iw/16,ih/9),iw,ih/9*16)]:[if(lte(iw/16,ih/9),iw/16*9,ih)]"; # crop to 16:9
        "c" = "vf toggle crop=in_w:in_w/1.78";
        "CTRL+c" = "vf toggle crop=in_w:in_w/2.38";

        "CTRL+v" = "af toggle dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
        "CTRL+b" = "af toggle earwax";
        "CTRL+n" = "af toggle loudnorm=I=-20";
        "CTRL+m" = "cycle-values audio-channels stereo mono auto-safe"; # toggle mono audio

        "CTRL+WHEEL_UP" = "add target-peak 25";
        "CTRL+WHEEL_DOWN" = "add target-peak -25";

        "CTRL+_" = "add audio-delay -0.100";
        "CTRL++" = "add audio-delay 0.100";

        "CTRL+-" = "add video-scale-x -0.01; add video-scale-y -0.01";
        "CTRL+=" = "add video-scale-x 0.01; add video-scale-y 0.01";


        "a" = "vf toggle hflip";
        "b" = "cycle deband";

        "HOME" = "seek 0 absolute";
      };

      scriptOpts.osc = {
        # bring back original controls
        audio_track_mbtn_left_command = "cycle audio";
        audio_track_mbtn_mid_command = "script-binding select/select-aid; script-message-to osc osc-hide";
        audio_track_mbtn_right_command = "cycle audio down";
        sub_track_mbtn_left_command = "cycle sub";
        sub_track_mbtn_mid_command = "script-binding select/select-sid; script-message-to osc osc-hide";
        sub_track_mbtn_right_command = "cycle sub down";
      };

      scripts = [
        #pkgs.mpvScripts.autocrop
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