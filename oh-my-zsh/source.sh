#!/bin/zsh

# Possible Oh My Zsh locations to check
possible_zsh_locations=(
  "$ZSH"
  "$HOME/.oh-my-zsh"
  "$HOME/.local/oh-my-zsh"
)

# Find existing installation
found_zsh=""
for location in "${possible_zsh_locations[@]}"; do
  if [ -d "$location" ]; then
    found_zsh="$location"
    break
  fi
done

if [ -z "$found_zsh" ]; then
    echo "Oh My Zsh could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
  ZSH_THEME="powerlevel10k/powerlevel10k"
  plugins+=(aliases ubuntu history zsh-autosuggestions bazel emotty)
  source $ZSH/oh-my-zsh.sh
fi
