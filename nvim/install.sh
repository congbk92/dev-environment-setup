#!/bin/bash

set -e

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p ~/.config

if [ -L "$HOME/.config/nvim" ]; then
    echo "Updating nvim config symlink..."
elif [ -e "$HOME/.config/nvim" ]; then
    echo "~/.config/nvim already exists as a directory, skipping symlink."
    exit 0
else
    echo "Linking nvim config to ~/.config/nvim..."
fi

ln -sfnT "${cur_dir}/config" "$HOME/.config/nvim"
echo "nvim config linked: ~/.config/nvim -> ${cur_dir}/config"
