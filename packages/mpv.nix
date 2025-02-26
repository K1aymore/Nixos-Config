{ lib, config, systemSettings, ... }:

{

  home-manager.users.klaymore.programs.mpv = {
    enable = true;
    config = lib.mkMerge [ rec {
      fullscreen = true;
      # fs-screen = 0; # screen numbers change sometimes
      # screen = 0;
      # autofit = "100%";
      # window-maximized = true;
      keep-open = false;

      alang = "swe,sv,Swedish,eng,en,enUS,en-US";
      # af = "dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
      # af = "loudnorm=I=-20";
      volume-max = 200;


      # best quality, except for 8K which is dumb
      ytdl-format = "bestvideo[height<=2160]+bestaudio/best[height<=2160]";

      profile = "gpu-hq";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      deband = true;

      # Causes jitter and missed/delayed frames with display-resample
      hwdec = if video-sync == "audio" then "auto" else "no";

      # SSimSuperRes causes jitter with display-resample
      video-sync = "display-resample-vdrop";
      interpolation = true;
      tscale = "oversample";
    }
    (lib.mkIf systemSettings.hdr { # always output in HDR even for SDR videos
      vo = "gpu-next"; # dmabuf-wayland doesn't work with hdr
      gpu-api = "vulkan";
      gpu-context = "waylandvk";

      target-trc = "pq"; # Output in HDR
      #target-prim = "bt.2020"; # should be correct on `auto`
      target-colorspace-hint = true; # makes no difference when target-trc=srgb
    })
    (lib.mkIf (config.networking.hostName == "pc") {
      # No visible difference but what the hey
      scale = lib.mkForce "ewa_lanczos4sharpest";
    })
    ];

    profiles = {
      # Play SDR video nicely (maybe not "correctly") in HDR
      SDR = lib.mkIf systemSettings.hdr {
        profile-cond = "video_params and p[\"video-params/primaries\"] ~= \"bt.2020\""; # only on SDR videos
        profile-restore = "copy";

        # Purple test She-Ra S5E6 4:39
        # Red test Arcane S1E7 7:54
        # Saturation test Arcane S1E7 21:37 <- everything except bt.2020 is oversaturated
        #
        # bt.709: way oversaturated
        # bt.470m: messed up purples
        # dci-p3: Pretty good balance
        # display-p3: like dci-p3 with less reds
        # film-c: Between bt.2020 and dci-p3. Looks pretty good
        # aces-ap1: A lot like bt.2020 except worse
        # bt.2020: correct but looks undersaturated compared to SDR colors at +40%
        # apple: more saturated than dci-p3, messed up purples
        # adobe: similar saturation to dci-p3 but greens are way too yellow
        # cie1931: like adobe but with messed up purples
        #target-prim = "bt.2020"; # I think auto works fine

        # Tried it and it's noticeably more saturated sometimes
        #saturation = 5;


        # caps at 203 nits unless doing inverse-tone-mapping
        # "auto" is affected by OS SDR brightness
        # anything above 203 is the same as auto with OS SDR Brightness at 203
        target-peak = 500;

        tone-mapping = "bt.2446a"; # Only affects inverse-tone-mapping, all other options bad
        inverse-tone-mapping = false; # Not good for 2D animation
      };
    };
    # test with mpv --input-test --force-window --idle
    bindings = {
      "CTRL+`" = "set target-peak auto";
      "CTRL+1" = "set target-peak 500";
      "CTRL+2" = "cycle inverse-tone-mapping";

      "CTRL+3" = "cycle target-colorspace-hint";
      "CTRL+4" = "cycle-values target-prim bt.2020 bt.709 auto";
      # in HDR, "auto" does gamma2.2 while --no-config gives bt.1886 (matches VLC)
      "CTRL+5" = "cycle-values target-trc pq auto";
      "CTRL+6" = "cycle-values tone-mapping bt.2446a auto";
      "CTRL+7" = "cycle-values video-sync display-resample-vdrop audio";

      # https://www.reddit.com/r/NixOS/comments/191wg98/using_a_directory_from_a_git_repo_as_source_for_a/
      "CTRL+8" = "";
      "CTRL+9" = "no-osd change-list glsl-shaders set \"${./-mpvShaders/SSimSuperRes.glsl}\"; show-text \"SSimSuperRes\"";
      "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";

      "CTRL+i" = "cycle interpolation";
      
      # https://github.com/mpv-player/mpv/issues/8413
      "C" = "vf toggle crop=[if(lte(iw/16,ih/9),iw,ih/9*16)]:[if(lte(iw/16,ih/9),iw/16*9,ih)]"; # crop to 16:9

      "CTRL+v" = "af toggle dynaudnorm=framelen=250:gausssize=11:maxgain=12:peak=0.8:targetrms=0.8";
      "CTRL+b" = "af toggle earwax";
      "CTRL+n" = "af toggle loudnorm=I=-20";

      "CTRL+WHEEL_UP" = "add target-peak 25";
      "CTRL+WHEEL_DOWN" = "add target-peak -25";

      "a" = "vf toggle hflip";
      "b" = "cycle deband";

      "HOME" = "seek 0 absolute";
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

}