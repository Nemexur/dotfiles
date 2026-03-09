{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "noctalia-shell ipc call lockScreen lock"; # avoid starting multiple instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        ignore_dbus_inhibit = false; # whether to ignore dbus-sent idle-inhibit requests
      };
      listener = [
        {
          timeout = 600; # 10 min
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        {
          timeout = 1200; # 20 min
          on-timeout = "noctalia-shell ipc call lockScreen lock"; # lock screen
        }
      ];
    };
  };
}
