{
  flake.modules.homeManager.noctalia = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs.unstable; [
      wl-clipboard
      wf-recorder
    ];

    home.sessionVariables = {
      "NOCTALIA_PAM_SERVICE" = "greetd";
    };

    programs.noctalia = {
      enable = true;
      settings = {
        backdrop = {
          blur_intensity = 0.1;
          enabled = true;
        };
        bar = {
          default = {
            background_opacity = 0.8;
            capsule = true;
            capsule_opacity = 0.8;
            center = ["workspaces"];
            end = [
              "notifications"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "clock"
              "session"
              "control-center"
            ];
            margin_edge = 1;
            margin_ends = 5;
            radius = 15;
            start = ["launcher" "wallpaper"];
          };
        };
        battery.warning_threshold = 20;
        dock = {
          background_opacity = 0.8;
          enabled = true;
          icon_size = 42;
          margin_edge = 2;
          reserve_space = false;
          smart_auto_hide = true;
        };
        location.auto_locate = true;
        lockscreen.allow_empty_password = true;
        shell = {
          animation.speed = 1.5;
          font_family = "Lilex Nerd Font";
          keyboard_layout = {
            custom_labels = {
              "English (US)" = "US";
              "Russian (typewriter)" = "RU";
            };
          };
          niri_overview_type_to_launch_enabled = true;
        };
        theme = {
          builtin = "Eldritch";
          source = "wallpaper";
          wallpaper_scheme = "soft";
        };
        wallpaper = {
          automation.enabled = true;
          directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
          fill_mode = "center";
        };
      };
    };
  };
}
