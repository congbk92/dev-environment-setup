#!/bin/bash

if ! command -v bat &> /dev/null; then
    echo "bat could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
    export BAT_THEME="TwoDark"
    alias cat='bat --pager=never'
    # echo "bat is ready to use with theme $BAT_THEME"
fi
