#!/bin/bash

# Install fzf-git to ~/.local/fzf-git

set -e

FZF_GIT_DIR="$HOME/.local/fzf-git"

# Install fzf-git if not already available
if [ -f "$FZF_GIT_DIR/fzf-git.sh" ] && command -v __fzf_git &> /dev/null; then
    echo "fzf-git is already installed at $FZF_GIT_DIR"
    read -p "Would you like to reinstall fzf-git? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Reinstalling fzf-git..."
        rm -f "$FZF_GIT_DIR/fzf-git.sh"
    else
        echo "Skipping fzf-git installation."
        SKIP_FZF_GIT=true
    fi
fi

if [ -z "$SKIP_FZF_GIT" ]; then
    echo "Installing fzf-git to $FZF_GIT_DIR..."
    mkdir -p "$FZF_GIT_DIR"
    curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$FZF_GIT_DIR/fzf-git.sh"
    chmod +x "$FZF_GIT_DIR/fzf-git.sh"
fi

[ -z "$SKIP_FZF_GIT" ] && echo "fzf-git installed successfully to $FZF_GIT_DIR"
