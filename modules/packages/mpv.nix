{ config, lib, ... }:

{

  config = lib.mkIf config.klaymore.programs.mpv.enable {

    home-manager.users.klaymore.programs.mpv = {
      enable = true;
      config = lib.mkMerge [ {
        fullscreen = true;
        # fs-screen = 0; # screen numbers change sometimes
        # screen = 0;
        # autofit = "100%";
        # window-maximized = true;
        keep-open = false;

        alang = "swe,sv,Swedish,";
        sid = "no";
        # af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
        # af = "loudnorm=I=-20";
        volume-max = 200;
        hr-seek = true;


        # best quality, except for 8K which is dumb
        ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";

        # dmabuf-wayland works but worse quality.
        vo = "gpu-next";
        hwdec = "auto"; # Causes jitter and missed/delayed frames with display-resample
        gpu-api = "vulkan";
        gpu-context = "waylandvk";

        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        dscale = "mitchell";
        deband = true;

        # affects HDR->SDR, and HDR when very bright
        # in HDR, spline/auto preserves details better, bt.2446a becomes spline when target-peak > 2400
        # for HDR->SDR, bt.2446a darker & more contrasted
        #tone-mapping = "bt.2446a";

        # SSimSuperRes causes jitter with display-resample(-vdrop)
        video-sync = "audio";
        interpolation = true;
        tscale = "oversample";
      }

      (lib.mkIf config.klaymore.gui.hdr { # always output in HDR even for SDR videos
        # pq outputs in HDR always, darker/contraster for SDR content than bt.1886/auto.
        # works on SDR displays too but cranks screen brightness to max, worse blacks.
        #target-trc = "pq";

        # should be correct on `auto`
        #target-prim = "bt.2020";

        # needs to be on/auto for HDR in HDR
        # if on/auto, not affected by sRGB Color Intensity slider in HDR.
        # makes no difference when outputting bt.1886 in SDR
        # if on/auto, makes HDR content in SDR processed by Plasma, not as nice
        # changes display to display-p3 for SDR but works okay with target-prim on auto
        target-colorspace-hint = "auto";
      })

      (lib.mkIf config.klaymore.powerful {
        # No visible difference but what the hey
        scale = lib.mkForce "ewa_lanczos4sharpest";
      })
      ];

      profiles = {
        # Play SDR video nicely in HDR
        SDR = lib.mkIf config.klaymore.gui.hdr {
          # only on SDR videos
          profile-cond = "video_params and p[\"video-params/primaries\"] ~= \"bt.2020\"";
          profile-restore = "copy";

          #saturation = 5; # Tried it and it's noticeably more saturated sometimes
          #target-peak = 500; # with Plasma 6.3 no effect in pq, makes sdr dark

          inverse-tone-mapping = false; # Not good
        };
      };

      # test with mpv --input-test --force-window --idle
      bindings = {
        "CTRL+`" = "set target-peak auto";
        "CTRL+1" = "set target-peak 500";
        "CTRL+2" = "cycle inverse-tone-mapping";

        "CTRL+3" = "cycle target-colorspace-hint";
        "CTRL+4" = "cycle-values target-prim bt.2020 bt.709 auto";

        # srgb way worse for hdr->sdr. same otherwise. hlg busted. pq too dark on sdr display
        "CTRL+5" = "cycle-values target-trc pq bt.1886 auto";
        "CTRL+6" = "cycle-values tone-mapping bt.2446a auto";
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