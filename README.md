# tmux config

Personal tmux configuration managed with [TPM](https://github.com/tmux-plugins/tpm).

> For a full command and key binding reference: [English](docs/en/tmux-reference.md) · [Português](docs/pt-br/tmux-reference.md)

## Setup

Clone to any folder you prefer:

```bash
git clone <repo> /path/to/your/folder
cd /path/to/your/folder
git submodule update --init
```

### Symlinks

Tmux expects its files at `~/.tmux` and `~/.tmux.conf`. Create symlinks pointing to your cloned folder.

> If `~/.tmux` or `~/.tmux.conf` already exist, remove or back them up before creating the symlinks.

**macOS / Linux / BSD**

```bash
ln -s /path/to/your/folder ~/.tmux
ln -s /path/to/your/folder/.tmux.conf ~/.tmux.conf
```

**Windows (WSL)**

Run inside your WSL terminal — same commands as Linux:

```bash
ln -s /path/to/your/folder ~/.tmux
ln -s /path/to/your/folder/.tmux.conf ~/.tmux.conf
```

> Native Windows is not supported. tmux on Windows requires WSL.

### Install plugins

Open tmux and press:

```
prefix + I
```

## Key Bindings

| Binding | Action |
|---------|--------|
| `Ctrl-a` | Prefix (remapped from `Ctrl-b`) |
| `prefix + r` | Reload config |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + Ctrl-l` | Clear screen (`Ctrl-l` alone is used by vim-tmux-navigator) |
| `prefix + Ctrl-k` | Clear pane scrollback (keeps a running app's context, e.g. Claude Code) |
| `prefix + D` | Split pane side by side, new (right) pane at 1/3 width |
| `prefix + Ctrl-s` | Save session (tmux-resurrect) |
| `prefix + Ctrl-r` | Restore session (tmux-resurrect) |

## Plugins

- [catppuccin/tmux](https://github.com/catppuccin/tmux) — theme
- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) — plugin manager
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) — seamless vim/tmux navigation
- [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) — save/restore sessions (windows, panes, working directories, pane contents)
- [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) — auto-saves every 15 min and auto-restores the last session on tmux startup

Session persistence protects against lost work when the tmux server dies unexpectedly (crash, `kill-server`, reboot). It restores window/pane layout and working directories, not the internal state of a running program — see the [full reference](docs/en/tmux-reference.md#persist-sessions-across-crashes-and-reboots) for details.

## Themes

Theme files live in `themes/`. One is active at a time via `source-file` in `.tmux.conf`.

| Theme | Flavours |
|-------|---------|
| Catppuccin (**active**) | `frappe`, `mocha`, `macchiato`, `latte` |
| TokyoNight | `day`, `moon`, `night`, `storm` |
| Dracula | — |
| Rose Pine | `main`, `moon`, `dawn` |

### Switching themes

Edit `.tmux.conf` and toggle the `source-file` lines under `#Themes`, then:

```bash
tmux kill-server && tmux
```

### Catppuccin status bar

| Position | Modules |
|----------|---------|
| Left | `session` |
| Right | `application` → `date_time` → `user` |

## Linux console (TTY)

The Linux console (the text VT on a headless machine's monitor, `TERM=linux`) cannot draw Nerd Font glyphs, so the powerline separators of the themes (U+E0B0–U+E0B3) show up as garbage there. `scripts/tty-status.sh` fixes the status bar **per client**: it keeps two versions of `status-left`, `status-right`, `window-status-format` and `window-status-current-format`, and each client gets the one for its terminal (`#{client_termname}`). A session attached from the console and over SSH at the same time shows the plain bar on the console and the original one over SSH.

In the plain version, solid separators are dropped and thin ones become `|`.

It is opt-in per machine and Linux-only. Enable it in `local.conf`, a gitignored file sourced by `.tmux.conf` right after the theme:

```bash
echo 'set -g @tty_ascii on' >> ~/.config/tmux/local.conf
```

Then reload with `prefix + r`. Machines without `local.conf` (or with the option off) are unaffected.

> Covers the manual themes (`tokyonight_*`), which write the glyphs straight into the formats. Plugin-based themes (catppuccin, dracula, rose-pine) keep their glyphs in plugin options expanded at render time, which the script does not reach.
