#!/bin/bash

if ! command -v nvim &> /dev/null; then
    echo "Neovim could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
    export EDITOR="nvim"
    alias vim="nvim"
    alias vi="nvim"
    # echo "Neovim is ready to use as default editor"
fi
