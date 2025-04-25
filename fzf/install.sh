#!/bin/bash

# Install fzf (fuzzy finder) to ~/.local/fzf and fzf-git to ~/.local/fzf-git

set -e

TOOL_NAME="fzf"
INSTALL_DIR="$HOME/.local/$TOOL_NAME"
FZF_GIT_DIR="$HOME/.local/fzf-git"
BIN_DIR="$HOME/.local/bin"

# Check if fzf is already available
if command -v fzf &> /dev/null; then
    echo "fzf is already installed at $(which fzf)"
    read -p "Would you like to force reinstall? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo "Proceeding with forced reinstall..."
fi

echo "Installing $TOOL_NAME to $INSTALL_DIR..."

# Create directories if they don't exist
mkdir -p "$INSTALL_DIR" "$FZF_GIT_DIR" "$BIN_DIR"

# Clone/update fzf repository
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Updating existing fzf repository..."
    git -C "$INSTALL_DIR" pull --rebase
else
    echo "Cloning fzf repository..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$INSTALL_DIR"
fi

# Install fzf
echo "Running fzf install script..."
"$INSTALL_DIR/install" --bin

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
    curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$FZF_GIT_DIR/fzf-git.sh"
    chmod +x "$FZF_GIT_DIR/fzf-git.sh"
fi

# Link binaries
ln -sf "$INSTALL_DIR/bin/fzf" "$BIN_DIR/fzf"
ln -sf "$INSTALL_DIR/bin/fzf-tmux" "$BIN_DIR/fzf-tmux"

echo "$TOOL_NAME installed successfully to $INSTALL_DIR"
[ -z "$SKIP_FZF_GIT" ] && echo "fzf-git installed successfully to $FZF_GIT_DIR"
echo "Binaries linked to $BIN_DIR"
