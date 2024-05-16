#Dracula theme configuration

set -g @plugin 'dracula/tmux'
set -g @dracula-plugins "git cpu-usage ram-usage time"
set -g @dracula-cpu-usage-label "CPU"
set -g @dracula-cpu-usage-colors "dark_gray cyan"
set -g @dracula-ram-usage-colors "gray cyan"
set -g @dracula-time-format "%H:%M"
set -g @dracula-show-powerline true
set -g @dracula-show-flags true
set -g @dracula-show-empty-plugins false
set -g @dracula-show-left-icon session
set -g status-position top

