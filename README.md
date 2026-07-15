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
