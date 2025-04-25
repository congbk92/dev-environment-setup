#!/bin/bash

# Install eza to ~/.local/eza

set -e

TOOL_NAME="eza"
INSTALL_DIR="$HOME/.local/$TOOL_NAME"
BIN_DIR="$HOME/.local/bin"
LATEST_RELEASE_URL="https://api.github.com/repos/eza-community/eza/releases/latest"

echo "Installing $TOOL_NAME..."

# Create directories if they don't exist
mkdir -p "$INSTALL_DIR" "$BIN_DIR"

# Get latest release info
release_info=$(curl -s "$LATEST_RELEASE_URL")
download_url=$(echo "$release_info" | grep -o "https://.*eza_x86_64-unknown-linux-gnu.tar.gz" | head -n 1)
if [ -z "$download_url" ]; then
    echo "Failed to find download URL for $TOOL_NAME"
    exit 1
fi

# Download and extract
echo "Downloading $TOOL_NAME from $download_url..."
curl -L "$download_url" -o "$INSTALL_DIR/$TOOL_NAME.tar.gz"
tar -xzf "$INSTALL_DIR/$TOOL_NAME.tar.gz" -C "$INSTALL_DIR" --strip-components=1
rm "$INSTALL_DIR/$TOOL_NAME.tar.gz"

# Find the binary path
binary_path=$(find "$INSTALL_DIR" -name "eza" -type f | head -n 1)
if [ -z "$binary_path" ]; then
    echo "Failed to find $TOOL_NAME binary in the extracted files"
    exit 1
fi

# Create symlink
ln -sf "$binary_path" "$BIN_DIR/eza"

echo "$TOOL_NAME installed successfully to $INSTALL_DIR"
echo "Binary linked to $BIN_DIR/eza"
