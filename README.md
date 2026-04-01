# tmux config

Personal tmux configuration managed with [TPM](https://github.com/tmux-plugins/tpm).

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

## Plugins

- [catppuccin/tmux](https://github.com/catppuccin/tmux) — theme
- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) — plugin manager
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) — seamless vim/tmux navigation

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
