#!/bin/bash
# Symlink configuration files
CUR_DIR=$(pwd)
mkdir -p ~/.config
[ -e "$HOME/.config/nvim" ] || ln -s $CUR_DIR/config ~/.config/nvim
