#!/usr/bin/env bash

# Catppuccin Frappé theme configuration

set -g @plugin 'catppuccin/tmux#v2.1.3'

# Flavour
set -g @catppuccin_flavor 'frappe'

# Window styling
set -g @catppuccin_window_status_style 'rounded'
set -g @catppuccin_window_text "#{window_name}"
set -g @catppuccin_window_current_text "#{window_name}"

# Status position
set -g status-position top

# Status bar
set -g status-left-length 100
set -g status-right-length 100


set -g status-left "#{E:@catppuccin_status_session}"
set -g status-right "#{E:@catppuccin_status_application}"
set -ag status-right "#{E:@catppuccin_status_date_time}"
set -ag status-right "#{E:@catppuccin_status_user}"
