#!/usr/bin/env bash

set -g status-position top

# GitHub Dark Dimmed colors for Tmux
# Palette: https://github.com/projekt0n/github-nvim-theme

set -g mode-style "fg=#539bf5,bg=#2d333b"

set -g message-style "fg=#539bf5,bg=#2d333b"
set -g message-command-style "fg=#539bf5,bg=#2d333b"

set -g pane-border-style "fg=#444c56"
set -g pane-active-border-style "fg=#539bf5"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#adbac7,bg=#22272e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1c2128,bg=#539bf5,bold] #S #[fg=#539bf5,bg=#22272e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#22272e,bg=#22272e,nobold,nounderscore,noitalics]#[fg=#539bf5,bg=#22272e] #{prefix_highlight} #[fg=#2d333b,bg=#22272e,nobold,nounderscore,noitalics]#[fg=#adbac7,bg=#2d333b] %Y-%m-%d  %I:%M %p #[fg=#539bf5,bg=#2d333b,nobold,nounderscore,noitalics]#[fg=#1c2128,bg=#539bf5,bold] #h "
if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
  set -g status-right "#[fg=#22272e,bg=#22272e,nobold,nounderscore,noitalics]#[fg=#539bf5,bg=#22272e] #{prefix_highlight} #[fg=#2d333b,bg=#22272e,nobold,nounderscore,noitalics]#[fg=#adbac7,bg=#2d333b] %Y-%m-%d  %H:%M #[fg=#539bf5,bg=#2d333b,nobold,nounderscore,noitalics]#[fg=#1c2128,bg=#539bf5,bold] #h "
}

setw -g window-status-activity-style "underscore,fg=#768390,bg=#22272e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#768390,bg=#22272e"
setw -g window-status-format "#[fg=#22272e,bg=#2d333b,nobold,nounderscore,noitalics]#[fg=#768390,bg=#2d333b] #I  #W #[fg=#2d333b,bg=#22272e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#22272e,bg=#2d333b,nobold,nounderscore,noitalics]#[fg=#539bf5,bg=#2d333b,bold] #I  #W#{?window_flags, #F,} #[fg=#2d333b,bg=#22272e,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#c69026]#[bg=#22272e]#[fg=#22272e]#[bg=#c69026]"
set -g @prefix_highlight_output_suffix ""
