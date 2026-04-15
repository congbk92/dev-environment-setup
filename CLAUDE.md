# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains scripts and configuration files to set up a development environment on Ubuntu. It uses devbox as the global package manager and provides modular configuration for shell, editor, and terminal tools.

## Installation

Run `./install.sh` from the repository root. This:
1. Symlinks `devbox/devbox.json` and `devbox/devbox.lock` to `~/.local/share/devbox/global/default/`
2. Runs `devbox global install` to install packages
3. Executes each component's `install.sh` script recursively

After installation, add to `~/.zshrc`:
```sh
source /path/to/this/repo/bashrc.sh
eval "$(fzf --zsh)"
```

## Architecture

### Component Structure
Each component directory (e.g., `tmux/`, `oh-my-zsh/`, `nvim/`, `fzf/`, `eza/`, `fd/`) follows a pattern:
- `install.sh` - Run once during setup (creates symlinks, installs dependencies)
- `source.sh` - Sourced by `bashrc.sh` for shell configuration (aliases, environment variables, functions)

### bashrc.sh
The entry point that discovers and sources all `source.sh` files throughout the repository. This allows adding new components by creating a directory with a `source.sh` file.

### devbox/devbox.json
Defines globally installed packages: eza, tmux, ripgrep, neovim, fzf, fd, git, go, python, lazygit, luarocks, tree-sitter, unzip, zstd, ollama, claude-code

### nvim/config
A git submodule (fork of kickstart.nvim). Custom plugins go in `nvim/config/lua/custom/plugins/`. The main `init.lua` imports from `custom.plugins` automatically.

### fzf
Uses fd as the default file finder. Includes fzf-git installation for git integration.

## Key Commands

- Run full setup: `./install.sh`
- Source all configs: `source bashrc.sh` (or add to `.zshrc`)
- Nvim plugins: `:Lazy` in neovim to manage plugins
- Nvim LSP tools: `:Mason` to manage LSP servers and formatters