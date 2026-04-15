#!/bin/bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running all install.sh scripts..."

ln -sfnT "${ROOT_DIR}/devbox/devbox.json" ~/.local/share/devbox/global/default/devbox.json
ln -sfnT "${ROOT_DIR}/devbox/devbox.lock" ~/.local/share/devbox/global/default/devbox.lock

devbox global install

find "$ROOT_DIR" -mindepth 2 -name ".git" -prune -o -name "install.sh" -type f -exec bash -c '
    dir="$(dirname "{}")"
    echo "Running install.sh in $dir"
    (cd "$dir" && ./install.sh)
' \;

echo "Installations complete."
echo "Don't forget to update ~/.zshrc by: "
echo "source ${ROOT_DIR}/bashrc.sh"
echo "eval \"\$(fzf --zsh)\""
