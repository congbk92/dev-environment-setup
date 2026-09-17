#!/bin/bash

set -e

root_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -L "$HOME/.tmux.conf" ]; then
    echo "Updating tmux config symlink..."
elif [ -e "$HOME/.tmux.conf" ]; then
    echo "~/.tmux.conf already exists, backing up..."
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bk"
else
    echo "Linking tmux config to ~/.tmux.conf..."
fi

ln -sfnT "${root_path}/.tmux.conf" "$HOME/.tmux.conf"
echo "tmux config linked: ~/.tmux.conf -> ${root_path}/.tmux.conf"
