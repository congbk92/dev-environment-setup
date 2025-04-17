#!/bin/bash

# Function to update PATH in shell config file
update_path() {
    local shell_config_file=$1
    local new_dir=$2

    if grep -q "export PATH=.*$new_dir" "$shell_config_file"; then
        echo "PATH already contains $new_dir"
    else
        echo "export PATH=\$PATH:$new_dir" >> "$shell_config_file"
        echo "PATH updated in $shell_config_file by append $new_dir"
    fi
}

# Function to determine the current shell and update PATH
install_path_update() {
    local new_dir=$1
    update_path "$HOME/.zshrc" "$new_dir"
    # Reload the shell configuration
    source "$HOME/.${current_shell}rc"
}


# Update and install dependencies
sudo apt-get update
sudo apt-get install -y zsh tmux curl git

# Install dependencies for nvim
sudo apt-get install -y make unzip gcc ripgrep

# Install nvim
NVIM_VERSION=v0.10.4
mkdir -p ~/.packages/nvim
wget -O ~/.packages/nvim/nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz
tar -zxvf ~/.packages/nvim/nvim-linux-x86_64.tar.gz -C ~/.packages/nvim/
install_path_update "~/.packages/nvim/nvim-linux-x86_64/bin"

# Symlink configuration files
CUR_DIR=$(pwd)
mkdir -p ~/.config
ln -sf $CUR_DIR/nvim ~/.config/nvim
ln -sf $CUR_DIR/tmux/.tmux.conf ~/.tmux.conf

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed at $HOME/.oh-my-zsh."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Installation complete."
