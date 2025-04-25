#!/bin/bash

if ! command -v lazygit &> /dev/null; then
    echo "lazygit could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
    # echo "lazygit is ready to use"
fi
