#!/bin/bash

if ! command -v lazygit &> /dev/null; then
    echo "lazygit could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        ./install.sh
    fi
else
    # echo "lazygit is ready to use"
fi
