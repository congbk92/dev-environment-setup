#!/bin/bash
echo "Running all install.sh scripts..."

ln -sfnT "${PWD}/devbox/devbox.json" ~/.local/share/devbox/global/default/devbox.json
ln -sfnT "${PWD}/devbox/devbox.lock" ~/.local/share/devbox/global/default/devbox.lock

devbox global install

find . -mindepth 2 -name "install.sh" -exec bash -c '
    dir="$(dirname "{}")"
    echo "Running install.sh in $dir"
    (cd "$dir" && ./install.sh)
' \;

echo "Installations complete."
echo "Don't forget to update ~/.zshrc by: "
echo "source ${PWD}/bashrc.sh"
echo "eval \"\$(fzf --zsh)\""
