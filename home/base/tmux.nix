{
  config,
  lib,
  pkgs,
  ...
}: let
  tmuxPlugins = pkgs.tmuxPlugins;
  colors = ''
    thm_logo="#4c4f69"
    thm_bg="#dce0e8"
    thm_fg="#cdd6f4"
    thm_cyan="#179299"
    thm_black="#e6e9ef"
    thm_gray="#2b3339"
    thm_magenta="#cba6f7"
    thm_pink="#8839ef"
    thm_red="#d20f39"
    thm_green="#40a02b"
    thm_yellow="#df8e1d"
    thm_blue="#89b4fa"
    thm_orange="#fe640b"
    thm_black4="#acb0be"
  '';
  options = ''
    # utf8 is on
    setw -q -g utf8 on
    set -q -g status-utf8 on

    # Rename window to reflect current program
    setw -g automatic-rename off

    # Renumber windows when a window is closed
    set -g renumber-windows on

    # Activity
    set -g bell-action none
    set -g visual-bell off
    set -g monitor-activity off
    set -g visual-activity off

    # Title
    set -g set-titles on
    set -g set-titles-string 'tmux | #S | #W'

    # Don't wrap searches; it's super confusing given tmux's reverse-ordering of position info in copy mode.
    set -w -g wrap-search off

    # Increase tmux messages display duration from 750ms to 4s
    set -g display-time 4000

    # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
    set -g status-interval 5

    # Super useful when using "grouped sessions" and multi-monitor setup
    setw -g aggressive-resize on
  '';
  keybinds = ''
    # Unbind
    unbind %
    unbind '"'
    unbind a
    unbind &
    unbind -T copy-mode-vi Enter

    # Reload config
    bind R source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."

    # Popup
    bind -n -N "Toggle popup window" M-i if-shell -F '#{==:#{session_name},popup}' {
        detach-client
    } {
        display-popup -d "#{pane_current_path}" -xC -yC -w 80% -h 75% -E 'tmux attach-session -t popup || tmux new-session -s popup -c "${config.home.homeDirectory}"'
    }

    # Show history in EDITOR
    bind * run-shell '${config.home.homeDirectory}/.local/bin/tmux-history'

    # Session
    bind -n M-s run-shell '${config.home.homeDirectory}/.local/bin/tmux-sessionizer'

    # Checkout to an existing session
    bind -n M-c run-shell '${config.home.homeDirectory}/.local/bin/tmux-switch'

    # Server
    bind K kill-server

    # Sessions
    bind C new-session

    # Windows
    bind c command-prompt -p "window name:" "new-window; rename-window '%%'"
    bind v split-window -h -l 35% -c "#{pane_current_path}"
    bind s split-window -v -l 35% -c "#{pane_current_path}"
    bind w kill-window
    bind p switch-client -n
    bind -n M-n next-window
    bind n switch-client -p
    bind -n M-p previous-window
    bind a last-window
    bind -n M-o last-window
    bind u choose-tree

    # Panes
    bind q kill-pane
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    bind -r H resize-pane -L 10
    bind -r J resize-pane -D 10
    bind -r K resize-pane -U 10
    bind -r L resize-pane -R 10
  '';
  status = ''
    # Status style
    set-option -g status-position top
    set -g pane-border-status top
    set -g pane-border-format "─"
    set -g pane-border-style "fg=#4c4f69"
    set -g pane-active-border-style "bg=default fg=#4c4f69"
    set -g popup-border-style "fg=#4c4f69"
    set -g status-bg default
    set -g status-style bg=default

    # Message
    set -g message-style bg=$thm_gray,fg=$thm_magenta

    # Pane status
    sep="#[fg=$thm_logo]⋮"
    session="#[fg=$thm_logo]    "
    battery_display="#[bg=default,nobold]#{battery_color_fg}#[bg=default,nobold]#{battery_percentage} #{battery_icon_status}"
    base_dir="#(basename #{d:pane_current_path})/#{b:pane_current_path}"

    set -g status-justify absolute-centre
    set -g status-left-length 60
    set -g status-right-length 130
    set -g status-left "#{tmux_mode_indicator} ''${sep} ''${session}"
    set -g status-right "#[fg=$thm_fg]  ''${base_dir} ''${sep} $battery_display "

    # Window status
    window_name="#[fg=$thm_logo,italics]#I''${sep}#[noitalics]#W"
    window_curr_name="#[fg=$thm_magenta,bg=$thm_gray,italics]#I''${sep}#[fg=$thm_fg,noitalics,bold]#W"
    window_symbol="#[fg=$thm_logo,italics]"
    window_curr_symbol="#[fg=$thm_magenta,bg=$thm_gray,italics]"
    window_left_sep="#[fg=$thm_gray,bg=default,nobold,nounderscore,noitalics]"
    window_right_sep="#[fg=#2b3339,bg=default,nobold,nounderscore,noitalics]"

    set -g window-status-format "''${window_symbol} ''${window_name}"
    set -g window-status-current-format "''${window_left_sep}''${window_curr_symbol} ''${window_curr_name}''${window_right_sep}"
  '';
in {
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    terminal = "tmux-256color";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "emacs";
    plugins = with tmuxPlugins; [
      extrakto
      open
      prefix-highlight
      {
        plugin = tmux-fzf;
        extraConfig = ''
          ### Colors
          ${colors}
          ### Options
          ${options}
          ### Keybinds
          ${keybinds}
          ### Status
          ${status}
        '';
      }
      {
        plugin = battery;
        extraConfig = lib.concatLines [
          "set -g @batt_icon_charge_tier8 ''"
          "set -g @batt_icon_charge_tier7 ''"
          "set -g @batt_icon_charge_tier6 ''"
          "set -g @batt_icon_charge_tier5 ''"
          "set -g @batt_icon_charge_tier4 ''"
          "set -g @batt_icon_charge_tier3 ''"
          "set -g @batt_icon_charge_tier2 ''"
          "set -g @batt_icon_charge_tier1 ''"
          "set -g @batt_icon_status_charged '󱈑'"
          "set -g @batt_icon_status_charging '󰂄'"
          "set -g @batt_icon_status_discharging '󰂌'"
          "set -g @batt_icon_status_attached '' # alts: ﮣ"
          "set -g @batt_icon_status_unknown '󰂑' # alts: 󱐋󰂑󱐋"
          "set -g @batt_color_status_primary_discharging '#e39b7b'"
          "set -g @batt_color_status_primary_charged '#a7c080'"
          "set -g @batt_color_status_primary_charging '#d9bb80'"
          "set -g @batt_color_status_primary_unknown '#e39b7b'"
          "set -g @batt_color_charge_primary_discharging '#e39b7b'"
          "set -g @batt_color_charge_primary_charged '#a7c080'"
          "set -g @batt_color_charge_primary_charging '#d9bb80'"
          "set -g @batt_color_charge_primary_unknown '#e39b7b'"
          "set -g @batt_color_primary_discharging '#e39b7b'"
          "set -g @batt_color_primary_charged '#a7c080'"
          "set -g @batt_color_primary_charging '#d9bb80'"
          "set -g @batt_color_primary_unknown '#e39b7b'"
          "set -g @batt_remain_short true"
        ];
      }
      {
        plugin = better-mouse-mode;
        extraConfig = "set -g @scroll-down-exit-copy-mode 'off'";
      }
      {
        plugin = fuzzback;
        extraConfig = "set -g @fuzzback-bind /";
      }
      {
        plugin = jump;
        extraConfig = "set -g @jump-key e";
      }
      {
        plugin = mode-indicator;
        extraConfig = lib.concatLines [
          "set -g @mode_indicator_empty_prompt ' TMUX'"
          "set -g @mode_indicator_empty_mode_style fg=$thm_magenta,bold"
          "set -g @mode_indicator_prefix_prompt ' TMUX'"
          "set -g @mode_indicator_prefix_mode_style fg=$thm_bg,bold"
          "set -g @mode_indicator_copy_prompt ' COPY'"
          "set -g @mode_indicator_copy_mode_style fg=$thm_blue,bold"
          "set -g @mode_indicator_sync_prompt ' SYNC'"
          "set -g @mode_indicator_sync_mode_style fg=$thm_red,bold"
        ];
      }
      {
        plugin = tmux-thumbs;
        extraConfig = lib.concatLines [
          "set -g @thumbs-key f"
          "set -g @thumbs-command 'echo -n {} | pbcopy && tmux display-message \"Copied to system clipboard\"'"
        ];
      }
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +''${vim_pattern}$'"
          bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
          bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
          bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
          bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l
        '';
      }
    ];
  };
}
