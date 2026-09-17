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

# Install the auto-title plugin (reinstalling replaces it, so re-running updates it)
if command -v herdr >/dev/null 2>&1; then
    echo "Installing herdr-auto-title plugin..."
    if herdr plugin install kryptamine/herdr-auto-title --yes; then
        echo "Note: the plugin loads when the herdr server starts; run 'herdr server stop' if herdr is running"
    else
        echo "Warning: herdr-auto-title plugin install failed (config linked; re-run to retry)" >&2
    fi
else
    echo "herdr not found on PATH, skipping plugin install" >&2
fi
