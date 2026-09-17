# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains scripts and configuration files to set up a development environment on Ubuntu. It uses devbox as the global package manager and provides modular configuration for shell, editor, and terminal tools.

## Installation

Run `./install.sh` from the repository root. This:
1. Symlinks `devbox/devbox.json` and `devbox/devbox.lock` to `~/.local/share/devbox/global/default/`
2. Runs `devbox global install` to install packages
3. Executes each component's `install.sh` script recursively (skipping nested `.git` dirs)

After installation, add to `~/.zshrc`:
```sh
source /path/to/this/repo/zshrc.sh
eval "$(fzf --zsh)"
```

## Architecture

### Component Structure
Each component directory (`tmux/`, `oh-my-zsh/`, `nvim/`, `fzf/`, `eza/`, `lgx/`, `herdr/`) follows a pattern:
- `install.sh` - Run once during setup (creates symlinks, installs dependencies)
- `source.sh` - Sourced by `zshrc.sh` for shell configuration (aliases, env vars, functions)

### zshrc.sh
The entry point that discovers and sources all `source.sh` files throughout the repository. It also prepends `~/.local/bin` to `PATH`. Adding a new component only requires creating a directory with a `source.sh` file.

### devbox/devbox.json
Defines globally installed packages via [devbox](https://www.jetify.com/devbox); see the file for the current list.

### Components

| Directory   | install.sh | source.sh | Notes |
|-------------|-----------|-----------|-------|
| `fzf/`      | No        | Yes       | Sets FZF defaults with fd backend |
| `eza/`      | No        | Yes       | Aliases `ls` to eza; adds fzf preview using eza/bat |
| `nvim/`     | Yes       | Yes       | Symlinks `nvim/config/` → `~/.config/nvim`; sets `$EDITOR=nvim` |
| `oh-my-zsh/`| Yes       | Yes       | Installs Oh My Zsh + powerlevel10k theme + zsh-autosuggestions |
| `tmux/`     | Yes       | Yes (empty) | Symlinks `tmux/.tmux.conf` → `~/.tmux.conf` |
| `lgx/`      | No        | Yes       | Fuzzy-find git repos and open them in lazygit. `source.sh` self-installs the `~/.local/bin/lgx` symlink and binds `Ctrl+G` / `Alt+G` |
| `herdr/`    | Yes       | No        | Symlinks `herdr/config.toml` → `~/.config/herdr/config.toml`; `prefix+f` opens an fzf directory picker and creates a workspace there |

### nvim/config
A git submodule (fork of kickstart.nvim). Custom plugins go in `nvim/config/lua/custom/plugins/`. The main `init.lua` imports from `custom.plugins` automatically.

### fzf
Uses fd as the default file finder (`FZF_DEFAULT_COMMAND`). The `CTRL-G` key is bound to `lgx` by `lgx/source.sh`.

### oh-my-zsh
Plugins enabled: `aliases`, `ubuntu`, `history`, `zsh-autosuggestions`, `bazel`, `emotty`
Theme: `powerlevel10k/powerlevel10k`

### tmux
Config (`tmux/.tmux.conf`) enables mouse, 256-color terminal, and sets escape-time to 10ms. `source.sh` exists but is empty — add tmux shell aliases/env vars there if needed.

### herdr
Config (`herdr/config.toml`) is symlinked to `~/.config/herdr/config.toml`. The custom keybinding `prefix+f` opens a popup running fzf over fd-listed directories under `~` and creates a new herdr workspace in the selected directory. Run `herdr server reload-config` after changing the config.

`install.sh` also installs the [`kryptamine/herdr-auto-title`](https://github.com/kryptamine/herdr-auto-title) plugin via `herdr plugin install` (herdr clones and builds it into its own managed plugin dir; re-running replaces/updates it). The plugin loads only when the herdr server starts, so restart with `herdr server stop` after installing.

## Key Commands

- Run full setup: `./install.sh`
- Source all configs: `source zshrc.sh` (or add to `.zshrc`)
- Nvim plugins: `:Lazy` in neovim to manage plugins
- Nvim LSP tools: `:Mason` to manage LSP servers and formatters
