#!/bin/bash

NVIM_VERSION="0.10.3"
INSTALL_DIR="$HOME/.local/nvim"
BIN_DIR="$HOME/.local/bin"

echo "Installing Neovim to $INSTALL_DIR..."

# Download and extract Neovim
mkdir -p "$INSTALL_DIR"
curl -L "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1 || { echo "failed to install nvim ${NVIM_VERSION}"; exit 1; }

# Link binary
ln -sf "$INSTALL_DIR/bin/nvim" "$BIN_DIR/nvim"

# Symlink configuration files
CUR_DIR=$(pwd)
mkdir -p ~/.config
ln -sf $CUR_DIR/nvim/config ~/.config/nvim


echo "Neovim installed successfully!"
