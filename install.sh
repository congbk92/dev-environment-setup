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
    # Determine the current shell
    current_shell=$(basename "$SHELL")
    # Directory to be added to PATH
    new_dir=$1
    case $current_shell in
        bash)
            update_path "$HOME/.bashrc" "$new_dir"
            ;;
        zsh)
            update_path "$HOME/.zshrc" "$new_dir"
            ;;
        *)
            echo "Unsupported shell: $current_shell"
            ;;
    esac
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
CUR_DIR=$(pwd)


# Symlink configuration files
mkdir -p ~/.config
ln -sf $CUR_DIR/nvim ~/.config/nvim
#ln -sf $CUR_DIR/zsh/.zshrc ~/.zshrc
ln -sf $CUR_DIR/tmux/.tmux.conf ~/.tmux.conf

# Install Oh My Zsh
if [ -d $ZSH ]; then
    echo "Oh My Zsh already installed in $ZSH"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Installation complete."
