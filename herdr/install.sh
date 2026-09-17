#!/bin/bash

set -e

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p ~/.config/herdr

if [ -L "$HOME/.config/herdr/config.toml" ]; then
    echo "Updating herdr config symlink..."
elif [ -e "$HOME/.config/herdr/config.toml" ]; then
    echo "~/.config/herdr/config.toml already exists, backing up..."
    mv "$HOME/.config/herdr/config.toml" "$HOME/.config/herdr/config.toml.bk"
else
    echo "Linking herdr config to ~/.config/herdr/config.toml..."
fi

ln -sfnT "${cur_dir}/config.toml" "$HOME/.config/herdr/config.toml"
echo "herdr config linked: ~/.config/herdr/config.toml -> ${cur_dir}/config.toml"
