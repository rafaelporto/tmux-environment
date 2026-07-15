# tmux Reference

A practical reference for tmux commands, key bindings, and features.

> **This config's prefix is `Ctrl-a`** (remapped from the default `Ctrl-b`). All bindings below use `prefix` to mean `Ctrl-a`.

---

## Core Concepts

| Term | Description |
|------|-------------|
| **Session** | A named collection of windows. Survives terminal disconnection. |
| **Window** | A single screen inside a session, containing one or more panes. |
| **Pane** | A rectangular terminal area inside a window. |
| **Client** | A terminal connected to the tmux server. |

---

## CLI Commands

### Sessions

```bash
tmux                          # Start new unnamed session
tmux new -s <name>            # Start new named session
tmux attach                   # Attach to last session
tmux attach -t <name>         # Attach to named session
tmux ls                       # List sessions
tmux kill-session -t <name>   # Kill a session
tmux kill-server              # Kill all sessions and the server
```

### Windows

```bash
tmux new-window               # Create a new window
tmux rename-window <name>     # Rename current window
```

### Server

```bash
tmux source-file ~/.tmux.conf # Reload config without restarting
```

---

## Key Bindings

### Session

| Binding | Action |
|---------|--------|
| `prefix + d` | Detach from session |
| `prefix + s` | Browse and switch sessions (tree view) |
| `prefix + $` | Rename current session |
| `prefix + (` | Switch to previous session |
| `prefix + )` | Switch to next session |

### Windows

| Binding | Action |
|---------|--------|
| `prefix + c` | Create new window |
| `prefix + ,` | Rename current window |
| `prefix + w` | Browse windows (tree view) |
| `prefix + n` | Go to next window |
| `prefix + p` | Go to previous window |
| `prefix + 0–9` | Go to window by number |
| `prefix + &` | Kill current window (with confirmation) |

### Panes

| Binding | Action |
|---------|--------|
| `prefix + %` | Split vertically (left/right) |
| `prefix + "` | Split horizontally (top/bottom) |
| `prefix + h/j/k/l` | Navigate panes (vim-style, this config) |
| `prefix + arrow keys` | Navigate panes (default) |
| `prefix + o` | Cycle to next pane |
| `prefix + q` | Show pane numbers (press number to jump) |
| `prefix + z` | Toggle pane zoom (fullscreen) |
| `prefix + {` | Swap pane with the one above |
| `prefix + }` | Swap pane with the one below |
| `prefix + x` | Kill current pane (with confirmation) |
| `prefix + !` | Break pane into its own window |

### Pane Resizing

| Binding | Action |
|---------|--------|
| `prefix + Ctrl-arrow` | Resize pane in arrow direction (small step) |
| `prefix + Alt-arrow` | Resize pane in arrow direction (large step) |

### Pane Layouts

| Binding | Action |
|---------|--------|
| `prefix + Alt-1` | Even horizontal |
| `prefix + Alt-2` | Even vertical |
| `prefix + Alt-3` | Main horizontal |
| `prefix + Alt-4` | Main vertical |
| `prefix + Alt-5` | Tiled |
| `prefix + Space` | Cycle through layouts |

### Copy Mode (vi)

This config uses vi keys (`mode-keys vi`).

| Binding | Action |
|---------|--------|
| `prefix + [` | Enter copy mode |
| `prefix + ]` | Paste from buffer |
| `q` | Exit copy mode |
| `h/j/k/l` | Move cursor |
| `w / b` | Jump word forward / backward |
| `0 / $` | Start / end of line |
| `g / G` | Go to top / bottom |
| `/` | Search forward |
| `?` | Search backward |
| `n / N` | Next / previous search match |
| `Space` | Start selection |
| `Enter` | Copy selection and exit |
| `v` | Toggle rectangle selection |

### Miscellaneous

| Binding | Action |
|---------|--------|
| `prefix + ?` | Show all key bindings |
| `prefix + :` | Open tmux command prompt |
| `prefix + t` | Show a clock |
| `prefix + ~` | Show tmux messages |
| `prefix + r` | Reload config (this config) |
| `prefix + Ctrl-l` | Clear screen (this config — sends `C-l` to the shell since `Ctrl-l` is captured by vim-tmux-navigator) |
| `prefix + Ctrl-k` | Clear pane scrollback (this config — runs `clear-history`; keeps the context of a running app like Claude Code) |

---

## Command Prompt

Press `prefix + :` to open the tmux command prompt. Useful commands:

```
new-window -n <name>          # New named window
split-window -h               # Split horizontally
split-window -v               # Split vertically
kill-pane                     # Kill current pane
resize-pane -D/U/L/R <n>      # Resize pane by n cells
swap-window -t <n>            # Move current window to position n
move-window -t <session>:<n>  # Move window to another session
set-option -g mouse on        # Enable mouse at runtime
```

---

## Mouse Support

Mouse is **enabled** in this config (`set -g mouse on`).

When enabled:
- Click a pane to focus it
- Drag pane borders to resize
- Click window tabs to switch
- Scroll to enter copy mode automatically (scrollback)
- Wheel events are forwarded to alternate-screen apps (e.g. Claude Code in fullscreen), so the wheel scrolls *their* content

**Caveat — text selection:** with mouse on, dragging selects into the tmux buffer, so the terminal's native selection / copy is bypassed. To select text in the terminal's own mode, hold `Option`/`Alt` (macOS, iTerm2/Terminal.app) while dragging.

To disable at runtime:

```
prefix + :  →  set-option -g mouse off
```

---

## Configuration Quick Reference

### Options

```bash
set -g <option> <value>       # Set global option
setw -g <option> <value>      # Set window option (alias: set-window-option)
set -s <option> <value>       # Set server option
```

### Common Options

```bash
set -g base-index 1           # Start window numbering at 1
set -g renumber-windows on    # Renumber windows when one is closed
set -g history-limit 50000    # Scrollback buffer size
set -g display-time 2000      # Status message display duration (ms)
set -g status-position top    # Move status bar to top
set -g mouse on               # Enable mouse support
setw -g mode-keys vi          # Use vi keys in copy mode
```

### Key Binding Syntax

```bash
bind <key> <command>          # Bind with prefix
bind -n <key> <command>       # Bind without prefix
bind -T copy-mode-vi <key> send-keys -X <action>  # Bind in copy mode
unbind <key>                  # Remove a binding
```

---

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `TMUX` | Set when inside a tmux session (contains socket path) |
| `TMUX_PANE` | Current pane ID (e.g. `%0`) |
| `$TERM` | Should be `screen-256color` or `tmux-256color` inside tmux |

---

## TPM — Plugin Manager

| Binding | Action |
|---------|--------|
| `prefix + I` | Install new plugins |
| `prefix + U` | Update installed plugins |
| `prefix + Alt-u` | Remove unused plugins |

Plugins are declared in `.tmux.conf`:

```bash
set -g @plugin 'owner/repo'
```

TPM must be initialized at the **very bottom** of `.tmux.conf`:

```bash
run '~/.config/tmux/plugins/tpm/tpm'
```

---

## Useful Patterns

### Two terminals on the same session, independent windows (Session Grouping)

Attaching two clients to the **same session** makes both mirror the same window. To allow each terminal to navigate windows independently, create a second session linked to the original:

```bash
# Terminal 1 — create the session
tmux new -s work

# Terminal 2 — create a linked session (session grouping)
tmux new-session -t work
```

Result:
- Each terminal navigates windows independently
- Pane content is shared (same process running)
- Creating or closing windows in one terminal reflects in the other

### Send a command to all panes in a window

```
prefix + :  →  setw synchronize-panes on
```

Repeat with `off` to disable. Useful for running the same command on multiple servers simultaneously.

### Floating overlay terminal (display-popup)

Open a floating terminal on top of whatever you are doing without leaving the current window:

```
prefix + :  →  display-popup -E
```

To map it to a key binding in `.tmux.conf`:

```bash
bind g display-popup -E
```

### Save pane output to a file (pipe-pane)

Capture everything printed in the current pane to a log file:

```
prefix + :  →  pipe-pane -o 'cat >> ~/tmux.log'
```

Run the same command again to stop capturing.

### Move a pane into another window (join-pane)

The reverse of `prefix + !`. Pull a pane from another window into the current one:

```
prefix + :  →  join-pane -s <session>:<window>.<pane>
```

Example — bring pane 1 from window 2 of the current session:

```
join-pane -s :2.1
```

### Share a session with another user (same server)

Two different users can connect to the same tmux socket for real-time terminal collaboration:

```bash
# User A — start tmux with a shared socket
tmux -S /tmp/shared new -s pair

# Grant access to the socket
chmod 777 /tmp/shared

# User B — attach via the shared socket
tmux -S /tmp/shared attach -t pair
```

Both users see and control the same session. Useful for pair programming in the terminal.

### Script a full dev environment

A shell script that creates a session, opens named windows, and runs commands in each — so your whole environment is one command away:

```bash
#!/usr/bin/env bash
SESSION="dev"

tmux new-session -d -s $SESSION -n editor
tmux send-keys -t $SESSION:editor "nvim ." Enter

tmux new-window -t $SESSION -n server
tmux send-keys -t $SESSION:server "npm run dev" Enter

tmux new-window -t $SESSION -n logs
tmux send-keys -t $SESSION:logs "tail -f app.log" Enter

tmux attach -t $SESSION
```

### Send keys to a pane without navigating to it (send-keys)

Run a command in any pane without leaving your current one:

```bash
tmux send-keys -t <session>:<window>.<pane> "command" Enter
```

Example — send a command to pane 0 of window 2 in session `work`:

```bash
tmux send-keys -t work:2.0 "git status" Enter
```

This is the foundation for tmux automation and scripting.

### Fuzzy session/window switcher with fzf

A fast interactive switcher combining `tmux ls` and `fzf`:

```bash
tmux attach -t $(tmux ls -F '#S' | fzf)
```

To switch windows within a session:

```bash
tmux select-window -t $(tmux list-windows -F '#I: #W' | fzf | cut -d: -f1)
```

Map it to a key binding for instant access:

```bash
bind f run-shell "tmux attach -t \$(tmux ls -F '#S' | fzf --tmux)"
```

### Rename current window automatically to the running command

```bash
set -g automatic-rename on
set -g automatic-rename-format '#{b:pane_current_path}'
```

### Persist sessions across crashes and reboots

Active in this config via [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) and [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum):

```bash
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'

set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'
```

- **Auto-save**: continuum saves the full session state every 15 minutes in the background.
- **Auto-restore**: the last saved state is restored automatically the next time tmux starts — no action needed.
- `prefix + Ctrl-s` — Save session manually
- `prefix + Ctrl-r` — Restore session manually
- Pane scrollback is captured (`@resurrect-capture-pane-contents`). `nvim` sessions are reopened via their own session strategy.
- Restore brings back windows, panes, and working directories — it does **not** resume the internal state of a running program (e.g. an in-progress Claude Code conversation); the pane reopens in the right directory so you can restart the tool there.

---

## References

- [tmux man page](https://man.openbsd.org/tmux) — Full command and option reference
- [tmux GitHub](https://github.com/tmux/tmux) — Source and releases
- [tmux wiki](https://github.com/tmux/tmux/wiki) — Getting started, advanced use, recipes
- [TPM](https://github.com/tmux-plugins/tpm) — Plugin manager
- [tmux-plugins org](https://github.com/tmux-plugins) — Community plugins
