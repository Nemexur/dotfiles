{
  flake.modules.homeManager.media = {
    lib,
    pkgs,
    config,
    ...
  }: let
    shaders = "${pkgs.unstable.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders/";
    profiles = {
      fsr = {
        name = "AMD FidelityFX Super Resolution";
        settings = {
          glsl-shader = "${shaders}FSR.glsl";
        };
      };
      cas = {
        name = "AMD FidelityFX Contrast Adaptive Sharpening";
        settings = {
          glsl-shader = "${shaders}CAS-scaled.glsl";
        };
      };
      fsr-cas = {
        name = "AMD FidelityFX Super Resolution + Contrast Adaptive Sharpening";
        settings = {
          glsl-shaders = [
            "${shaders}FSR.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}CAS-scaled.glsl"
          ];
        };
      };
      generic = {
        name = "FSRCNNX";
        settings = {
          dscale = "mitchell";
          cscale = "mitchell";
          glsl-shaders = [
            "${shaders}FSRCNNX_x2_16-0-4-1.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}SSimDownscaler.glsl"
            "${shaders}KrigBilateral.glsl"
          ];
        };
      };
      generic-high = {
        name = "FSRCNNX x16";
        settings = {
          dscale = "mitchell";
          cscale = "mitchell";
          glsl-shaders = [
            "${shaders}FSRCNNX_x2_8-0-4-1.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}SSimDownscaler.glsl"
            "${shaders}KrigBilateral.glsl"
          ];
        };
      };
      nnedi-high = {
        name = "NNEDI3 (64 Neurons)";
        settings = {
          dscale = "mitchell";
          cscale = "mitchell";
          glsl-shaders = [
            "${shaders}nnedi3-nns64-win8x6.hook"
          ];
          glsl-shaders-append = [
            "${shaders}SSimDownscaler.glsl"
            "${shaders}KrigBilateral.glsl"
          ];
        };
      };
      nnedi-very-high = {
        name = "NNEDI3 High (128 Neurons)";
        settings = {
          dscale = "mitchell";
          cscale = "mitchell";
          glsl-shaders = [
            "${shaders}nnedi3-nns128-win8x6.hook"
          ];
          glsl-shaders-append = [
            "${shaders}SSimDownscaler.glsl"
            "${shaders}KrigBilateral.glsl"
          ];
        };
      };
      anime4k-high-a = {
        name = "Anime4K A (HQ) - For Very Blurry/Compressed";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_VL.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-high-b = {
        name = "Anime4K B (HQ) - For Blurry/Ringing";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}CAS-scaled.glsl"
            "${shaders}Anime4K_Restore_CNN_Soft_VL.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-high-c = {
        name = "Anime4K C (HQ) - For Crisp/Sharp";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-high-aa = {
        name = "Anime4K AA (HQ) - For Very Blurry/Compressed";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}CAS-scaled.glsl"
            "${shaders}Anime4K_Restore_CNN_VL.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-high-bb = {
        name = "Anime4K BB (HQ) - For Blurry/Ringing";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_Soft_VL.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_Soft_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-high-ca = {
        name = "Anime4K CA (HQ) - For Crisp/Sharp";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
          ];
        };
      };
      anime4k-fast-a = {
        name = "Anime4K A (Fast) - For Very Blurry/Compressed";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
      anime4k-fast-b = {
        name = "Anime4K B (Fast) - For Blurry/Ringing";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_Soft_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
      anime4k-fast-c = {
        name = "Anime4K C (Fast) - For Crisp/Sharp";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Upscale_Denoise_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
      anime4k-fast-aa = {
        name = "Anime4K AA (Fast) - For Very Blurry/Compressed";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_S.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
      anime4k-fast-bb = {
        name = "Anime4K BB (Fast) - For Blurry/Ringing";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Restore_CNN_Soft_M.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_Soft_S.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
      anime4k-fast-cc = {
        name = "Anime4K CA (Fast) - For Crisp/Sharp";
        settings = {
          glsl-shaders = [
            "${shaders}Anime4K_Clamp_Highlights.glsl"
          ];
          glsl-shaders-append = [
            "${shaders}Anime4K_Upscale_Denoise_CNN_x2_M.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x2.glsl"
            "${shaders}Anime4K_AutoDownscalePre_x4.glsl"
            "${shaders}Anime4K_Restore_CNN_S.glsl"
            "${shaders}Anime4K_Upscale_CNN_x2_S.glsl"
          ];
        };
      };
    };
  in {
    home.packages = with pkgs.unstable;
      if pkgs.stdenv.isLinux
      then [
        # Image Viewer
        kdePackages.gwenview
        imv

        # Audio Control
        pavucontrol
        pulsemixer

        # Video/Audio Tools
        vlc
        vulkan-tools
        zoom-us

        # Jellyfin
        jellyfin-desktop
        mpv-shim-default-shaders
      ]
      else [iina];

    # Proper icons rendering for MacOS
    xdg.configFile = let
      uoscPackage = pkgs.unstable.mpvScripts.uosc;
    in
      lib.mkIf pkgs.stdenv.isDarwin {
        "mpv/fonts/uosc_icons.otf".source = "${uoscPackage}/share/fonts/uosc_icons.otf";
        "mpv/fonts/uosc_textures.ttf".source = "${uoscPackage}/share/fonts/uosc_textures.ttf";
      };

    programs.mpv = {
      enable = true;
      defaultProfiles = ["high-quality"];
      config = {
        # Video
        profile = "high-quality";
        vo = "gpu-next";
        gpu-api = "vulkan";
        fullscreen = true;
        force-seekable = true;
        hwdec = "auto";
        deband = false;
        deband-iterations = 1;
        deband-threshold = 48;
        deband-range = 16;
        deband-grain = 24;
        # Audio and Subtitles
        sub-auto = "all";
        slang = "en,eng,English";
        alang = "ja,jp,jpn,jap,Japanese,en,eng,English";
        demuxer-mkv-subtitle-preroll = true;
        volume = 100;
        volume-max = 200;
        blend-subtitles = true;
        audio-file-auto = "fuzzy";
        audio-normalize-downmix = true;
        # OSD
        osc = false;
        border = false;
        osd-bar = false;
        osd-font = "JetBrains Mono";
        cursor-autohide-fs-only = true;
        cursor-autohide = 300;
      };
      scriptOpts = {
        ytdl_hook.ytdl_path = "${lib.getExe pkgs.unstable.yt-dlp}";
      };
      bindings = {
        "tab" = "script-binding uosc/toggle-ui";
        "Shift+ENTER" = "script-binding uosc/download-subtitles";
        "ctrl+p" = "script-binding uosc/menu";
      };
      extraInput = ''
        s           script-binding uosc/subtitles                                                   #! Subtitles
        a           script-binding uosc/audio                                                       #! Audio tracks
        q           script-binding uosc/stream-quality                                              #! Stream quality
        p           script-binding uosc/items                                                       #! Playlist
        c           script-binding uosc/chapters                                                    #! Chapters
        >           script-binding uosc/next                                                        #! Navigation > Next
        <           script-binding uosc/prev                                                        #! Navigation > Prev
        alt+>       script-binding uosc/delete-file-next                                            #! Navigation > Delete file & Next
        alt+<       script-binding uosc/delete-file-prev                                            #! Navigation > Delete file & Prev
        alt+esc     script-binding uosc/delete-file-quit                                            #! Navigation > Delete file & Quit
        o           script-binding uosc/open-file                                                   #! Navigation > Open file
        #           set video-aspect-override no                                                    #! Utils > Aspect ratio > Default
        #           set video-aspect-override "16:9"                                                #! Utils > Aspect ratio > 16:9
        #           set video-aspect-override "4:3"                                                 #! Utils > Aspect ratio > 4:3
        #           set video-aspect-override "2.35:1"                                              #! Utils > Aspect ratio > 2.35:1
        #           script-binding uosc/audio-device                                                #! Utils > Audio devices
        #           script-binding uosc/editions                                                    #! Utils > Editions
        ctrl+s      async screenshot                                                                #! Utils > Screenshot
        alt+i       script-binding uosc/keybinds                                                    #! Utils > Key bindings
        O           script-binding uosc/show-in-directory                                           #! Utils > Show in directory
        #           script-binding uosc/open-config-directory                                       #! Utils > Open config directory
        #           script-binding uosc/update                                                      #! Utils > Update uosc
        ctrl+q      quit                                                                            #! Quit
        h           script-binding memo-history                                                     #! History
        g           cycle interpolation                                                             #! Video > Interpolation
        d           cycle deinterlace                                                               #! Video > Toggle Deinterlace
        ]           add speed +0.1; script-binding uosc/flash-speed                                 #! Video > Speed > Increase Speed
        [           add speed -0.1; script-binding uosc/flash-speed                                 #! Video > Speed > Decrease Speed
        BS          set speed 1; script-binding uosc/flash-speed                                    #! Video > Speed > Reset Speed
        b           cycle-values deband "yes" "no"                                                  #! Video > Deband > Toggle Deband

        CTRL+0 change-list glsl-shaders clr all; show-text "Shaders cleared"                        #! Profiles > Clear All Shaders
        CTRL+1 apply-profile fsr-cas; show-text "Profile: ${profiles.fsr-cas.name}"                 #! Profiles > ${profiles.fsr-cas.name}
        CTRL+2 apply-profile generic-high; show-text "Profile: ${profiles.generic-high.name}"       #! Profiles > ${profiles.generic-high.name}
        CTRL+3 apply-profile nnedi-very-high; show-text "Profile: ${profiles.nnedi-very-high.name}" #! Profiles > ${profiles.nnedi-very-high.name}
        CTRL+4 apply-profile anime4k-high-a; show-text "Profile: ${profiles.anime4k-high-a.name}"   #! Profiles > ${profiles.anime4k-high-a.name}
        CTRL+5 apply-profile anime4k-high-b; show-text "Profile: ${profiles.anime4k-high-b.name}"   #! Profiles > ${profiles.anime4k-high-b.name}
        CTRL+6 apply-profile anime4k-high-c; show-text "Profile: ${profiles.anime4k-high-c.name}"   #! Profiles > ${profiles.anime4k-high-c.name}
        CTRL+7 apply-profile anime4k-high-aa; show-text "Profile: ${profiles.anime4k-high-aa.name}" #! Profiles > ${profiles.anime4k-high-aa.name}
        CTRL+8 apply-profile anime4k-high-bb; show-text "Profile: ${profiles.anime4k-high-bb.name}" #! Profiles > ${profiles.anime4k-high-bb.name}
        CTRL+9 apply-profile anime4k-high-ca; show-text "Profile: ${profiles.anime4k-high-ca.name}" #! Profiles > ${profiles.anime4k-high-ca.name}
      '';
      profiles = {
        fsr = profiles.fsr.settings;
        cas = profiles.cas.settings;
        fsr-cas = profiles.fsr-cas.settings;
        anime4k-high-a = profiles.anime4k-high-a.settings;
        anime4k-high-b = profiles.anime4k-high-b.settings;
        anime4k-high-c = profiles.anime4k-high-c.settings;
        anime4k-high-aa = profiles.anime4k-high-aa.settings;
        anime4k-high-bb = profiles.anime4k-high-bb.settings;
        anime4k-high-ca = profiles.anime4k-high-ca.settings;
        anime4k-fast-a = profiles.anime4k-fast-a.settings;
        anime4k-fast-b = profiles.anime4k-fast-b.settings;
        anime4k-fast-c = profiles.anime4k-fast-c.settings;
        anime4k-fast-aa = profiles.anime4k-fast-aa.settings;
        anime4k-fast-bb = profiles.anime4k-fast-bb.settings;
        anime4k-fast-cc = profiles.anime4k-fast-cc.settings;
        genreric = profiles.generic.settings;
        generic-high = profiles.generic-high.settings;
        nnedi-high = profiles.nnedi-high.settings;
        nnedi-very-high = profiles.nnedi-very-high.settings;
        uosc-menu-pause = {
          profile-cond = ''get("user-data/uosc/menu/type") ~= nil'';
          profile-restore = "copy";
          pause = true;
        };
      };
      scripts = with pkgs.unstable.mpvScripts;
        [
          pkgs.unstable.mpvScripts.builtins.autodeint
          pkgs.unstable.mpvScripts.builtins.autoload
          evafast
          memo
          thumbfast
          uosc
          quality-menu
          chapterskip
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [mpris];
    };

    services.playerctld.enable = pkgs.stdenv.isLinux;
    services.jellyfin-mpv-shim = {
      enable = pkgs.stdenv.isLinux;
      settings = {
        enable_gui = true;
        enable_osc = false;
        mpv_ext = true;
        mpv_ext_start = true;
        mpv_ext_ipc = "/tmp/jellyfin-mpv-shim.sock";
        mpv_ext_path = "${lib.getExe' config.programs.mpv.finalPackage "mpv"}";
        mpv_ext_no_ovr = true;
        # Keyboard Shortcuts
        kb_stop = "ctrl+q";
        kb_menu = "ctrl+j";
        # Transcoding
        transcode_dolby_vision = false;
      };
    };
  };
}
