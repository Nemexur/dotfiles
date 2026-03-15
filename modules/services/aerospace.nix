{
  flake.modules.darwin.aerospace = {pkgs, ...}: {
    services.aerospace = {
      enable = true;
      package = pkgs.unstable.aerospace;
      settings = {
        accordion-padding = 30;
        after-startup-command = [];
        automatically-unhide-macos-hidden-apps = false;
        config-version = 2;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;
        gaps = {
          inner = {
            horizontal = 8;
            vertical = 8;
          };
          outer = {
            bottom = 8;
            left = 8;
            right = 8;
            top = 8;
          };
        };
        key-mapping = {
          preset = "qwerty";
        };
        mode = {
          main.binding = {
            alt-1 = "workspace W";
            alt-2 = "workspace T";
            alt-3 = "workspace C";
            alt-4 = "workspace Z";
            alt-5 = "workspace E";
            alt-comma = "layout accordion horizontal vertical";
            alt-ctrl-1 = "move-node-to-workspace W";
            alt-ctrl-2 = "move-node-to-workspace T";
            alt-ctrl-3 = "move-node-to-workspace C";
            alt-ctrl-4 = "move-node-to-workspace Z";
            alt-ctrl-5 = "move-node-to-workspace E";
            alt-ctrl-h = "move left";
            alt-ctrl-j = "move down";
            alt-ctrl-k = "move up";
            alt-ctrl-l = "move right";
            alt-ctrl-semicolon = "mode service";
            alt-ctrl-tab = "move-workspace-to-monitor --wrap-around next";
            alt-equal = "resize smart +50";
            alt-f = "fullscreen";
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";
            alt-minus = "resize smart -50";
            alt-slash = "layout tiles horizontal vertical";
          };
          service.binding = {
            alt-ctrl-h = ["join-with left" "mode main"];
            alt-ctrl-j = ["join-with down" "mode main"];
            alt-ctrl-k = ["join-with up" "mode main"];
            alt-ctrl-l = ["join-with right" "mode main"];
            backspace = ["close-all-windows-but-current" "mode main"];
            esc = ["reload-config" "mode main"];
            f = ["layout floating tiling" "mode main"];
            r = ["flatten-workspace-tree" "mode main"];
          };
        };
        on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
        on-mode-changed = [];
        persistent-workspaces = ["W" "T" "C" "Z" "E"];
        start-at-login = false;
      };
    };
  };
}
