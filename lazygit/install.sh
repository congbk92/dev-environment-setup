#!/bin/bash

LAZYGIT_VERSION="0.49.0"
INSTALL_DIR="$HOME/.local/lazygit"
BIN_DIR="$HOME/.local/bin"

echo "Installing lazygit to $INSTALL_DIR..."

# Download and extract lazygit
mkdir -p "$INSTALL_DIR"
curl -L "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" | tar -xz -C "$INSTALL_DIR"

# Link binary
ln -sf "$INSTALL_DIR/lazygit" "$BIN_DIR/lazygit"

echo "lazygit installed successfully!"
