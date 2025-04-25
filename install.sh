#!/bin/bash

# Update and install dependencies
# sudo apt-get update
# sudo apt-get install -y zsh tmux curl git

# Install dependencies for nvim
# sudo apt-get install -y make unzip gcc ripgrep

#!/bin/bash

echo "Running all install.sh scripts..."

find . -mindepth 2 -name "install.sh" -exec bash -c '
    dir="$(dirname "{}")"
    echo "Running install.sh in $dir"
    (cd "$dir" && ./install.sh)
' \;

echo "Installations complete."
echo "Don't forget to update ~/.zshrc by: "
echo "source ${PWD}/bashrc.sh"
echo "eval \"\$(fzf --zsh)\""
