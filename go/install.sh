#!/bin/bash

GO_VERSION="1.24.2"
INSTALL_DIR="$HOME/.local/go"
BIN_DIR="$HOME/.local/bin"

echo "Installing Go to $INSTALL_DIR..."

# Download and extract Go
mkdir -p "$INSTALL_DIR"
curl -L "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1

# Link binaries
ln -sf "$INSTALL_DIR/bin/go" "$BIN_DIR/go"
ln -sf "$INSTALL_DIR/bin/gofmt" "$BIN_DIR/gofmt"

echo "Go installed successfully!"
