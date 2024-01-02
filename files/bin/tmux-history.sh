#!/usr/bin/env bash

hist_file=$1
tmux capture-pane -pS -32768 > "${hist_file}"
tmux display-popup -y 10 -w 100 -h 20 -E "${EDITOR} ${hist_file}"
