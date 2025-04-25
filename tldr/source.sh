#!/bin/bash

if ! command -v tldr &> /dev/null; then
    echo "tldr could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        ./install.sh
    fi
else
    # echo "tldr is ready to use"
fi
