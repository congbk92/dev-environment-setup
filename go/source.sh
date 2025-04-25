#!/bin/bash

if ! command -v go &> /dev/null; then
    echo "Go could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
    # echo "Go is ready to use. GOPATH set to $GOPATH"
fi
