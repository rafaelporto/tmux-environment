# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a tmux configuration repository using [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) as a git submodule at `plugins/tpm`.

## Symlink Setup

Both `~/.tmux` and `~/.tmux.conf` are symlinked to this directory:

- `~/.tmux → ~/.config/tmux/`
- `~/.tmux.conf → ~/.config/tmux/.tmux.conf`

TPM installs plugins to `~/.tmux/plugins/` (its default), which resolves to `~/.config/tmux/plugins/`. No `TMUX_PLUGIN_MANAGER_PATH` override is needed.

## Applying Changes

- **Structural changes** (status bar layout, key bindings): `prefix + r`
- **Color changes** (theme flavour, new theme): `tmux kill-server && tmux`

## Plugin Management (TPM)

- **Install plugins**: `prefix + I`
- **Update plugins**: `prefix + U`
- **Remove unused plugins**: `prefix + alt + u`

TPM must always be initialized at the **very bottom** of `.tmux.conf`.

## Key Bindings

- **Prefix**: `Ctrl-a` (remapped from default `Ctrl-b`)
- **Reload config**: `prefix + r`
- **Pane navigation**: `prefix + h/j/k/l` (vim-style)
- **Mode keys**: vi

## Structure

- `.tmux.conf` — main config; sources one theme file and loads plugins via TPM
- `themes/` — theme files, one active at a time (others commented out in `.tmux.conf`)
- `plugins/` — TPM and installed plugins (not committed, managed by TPM)
- `plugins/tpm` — git submodule

## Active Plugins

- `catppuccin/tmux#v2.1.3` — active theme (declared inside `themes/catppuccin.tmux`)
- `tmux-plugins/tpm` — plugin manager (declared in `.tmux.conf`)
- `christoomey/vim-tmux-navigator` — seamless vim/tmux pane navigation (declared in `.tmux.conf`)

## Theme Architecture

Each theme file in `themes/` is self-contained:
- Declares its own `@plugin` if needed (e.g. catppuccin, dracula, rose-pine)
- Sets `status-position`, status bar layout, and plugin-specific options
- Is sourced from `.tmux.conf` before the TPM `run` line

**Critical ordering rule:** `@plugin` declarations and all `@catppuccin_*` options must be set **before** TPM runs. Status bar lines using `#{E:@catppuccin_status_*}` must use `set -ag` (without the `F` flag) so they are stored as literal format strings and expanded at render time — not at config load time when catppuccin variables aren't set yet.

## Active Theme: Catppuccin Frappé (`themes/catppuccin.tmux`)

- **Flavour**: `frappe`
- **Window style**: `rounded`
- **Status left**: `session`
- **Status right**: `application` → `date_time` → `user`
- **Status lengths**: left 100, right 100

### Switching Catppuccin Flavour

Edit `themes/catppuccin.tmux` and change `@catppuccin_flavor`. Available: `mocha`, `macchiato`, `frappe`, `latte`. Requires `tmux kill-server && tmux`.

### Available Catppuccin Modules

Built-in (no extra deps): `session`, `application`, `date_time`, `directory`, `host`, `load`, `uptime`, `user`

Require extra plugins/tools: `battery`, `clima`, `cpu`, `gitmux`, `kube`, `pomodoro_plus`, `weather`

### Catppuccin Module Customization

Override module options before catppuccin loads (uses `set -ogq` — won't overwrite pre-set values):
```bash
set -g @catppuccin_<module>_icon "icon"
set -g @catppuccin_<module>_color "#{@thm_color}"
set -g @catppuccin_<module>_text "text"
```

Example already in use: `set -g @catppuccin_user_text` is not overridden (uses `#(whoami)` default).

## Available Themes

| File | Type | Notes |
|------|------|-------|
| `catppuccin.tmux` | Plugin-based | **Active**. Declares `catppuccin/tmux#v2.1.3` |
| `tokyonight_day.tmux` | Manual (hex colors) | No extra plugin needed |
| `tokyonight_moon.tmux` | Manual (hex colors) | No extra plugin needed |
| `tokyonight_night.tmux` | Manual (hex colors) | No extra plugin needed |
| `tokyonight_storm.tmux` | Manual (hex colors) | No extra plugin needed |
| `dracula.tmux` | Plugin-based | Declares `dracula/tmux` |
| `rose-pine.tmux` | Plugin-based | Declares `rose-pine/tmux` |

To switch themes: comment the active `source-file` line in `.tmux.conf` and uncomment another, then restart tmux.
