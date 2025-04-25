#!/bin/bash

BAT_VERSION="v0.24.0"
INSTALL_DIR="$HOME/.local/bat"
BIN_DIR="$HOME/.local/bin"

echo "Installing bat to $INSTALL_DIR..."

# Download and extract bat
mkdir -p "$INSTALL_DIR"
curl -L "https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat-${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1

# Link binary
ln -sf "$INSTALL_DIR/bat" "$BIN_DIR/bat"

echo "bat installed successfully!"
