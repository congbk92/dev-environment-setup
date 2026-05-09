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
source /path/to/this/repo/bashrc.sh
eval "$(fzf --zsh)"
```

## Architecture

### Component Structure
Each component directory (`tmux/`, `oh-my-zsh/`, `nvim/`, `fzf/`, `eza/`, `fd/`) follows a pattern:
- `install.sh` - Run once during setup (creates symlinks, installs dependencies)
- `source.sh` - Sourced by `bashrc.sh` for shell configuration (aliases, env vars, functions)

### bashrc.sh
The entry point that discovers and sources all `source.sh` files throughout the repository. It also prepends `~/.local/bin` to `PATH`. Adding a new component only requires creating a directory with a `source.sh` file.

### devbox/devbox.json
Defines globally installed packages via [devbox](https://www.jetify.com/devbox):
`eza`, `tmux`, `ripgrep`, `neovim`, `fzf`, `fd`, `git`, `go`, `python`, `lazygit`, `luarocks`, `tree-sitter`, `unzip`, `zstd`, `claude-code`

### Components

| Directory   | install.sh | source.sh | Notes |
|-------------|-----------|-----------|-------|
| `fzf/`      | Yes       | Yes       | Installs fzf-git to `~/.local/fzf-git/`; sets FZF defaults with fd backend |
| `fd/`       | No        | Yes       | Sets FZF env vars to use fd (subset of `fzf/source.sh`) |
| `eza/`      | No        | Yes       | Aliases `ls` to eza; adds fzf preview using eza/bat |
| `nvim/`     | Yes       | Yes       | Symlinks `nvim/config/` → `~/.config/nvim`; sets `$EDITOR=nvim` |
| `oh-my-zsh/`| Yes       | Yes       | Installs Oh My Zsh + powerlevel10k theme + zsh-autosuggestions |
| `tmux/`     | Yes       | No        | Symlinks `tmux/.tmux.conf` → `~/.tmux.conf` |

### nvim/config
A git submodule (fork of kickstart.nvim). Custom plugins go in `nvim/config/lua/custom/plugins/`. The main `init.lua` imports from `custom.plugins` automatically.

### fzf
Uses fd as the default file finder (`FZF_DEFAULT_COMMAND`). Installs fzf-git for git-aware keybindings (e.g. `CTRL-G` prefix).

### oh-my-zsh
Plugins enabled: `aliases`, `ubuntu`, `history`, `zsh-autosuggestions`, `bazel`, `emotty`
Theme: `powerlevel10k/powerlevel10k`

### tmux
Config (`tmux/.tmux.conf`) enables mouse, 256-color terminal, and sets escape-time to 10ms. No `source.sh` (tmux config is static).

## Key Commands

- Run full setup: `./install.sh`
- Source all configs: `source bashrc.sh` (or add to `.zshrc`)
- Nvim plugins: `:Lazy` in neovim to manage plugins
- Nvim LSP tools: `:Mason` to manage LSP servers and formatters
