#!/bin/bash

# Configure environment for eza

TOOL_NAME="eza"
BINARY_PATH="$HOME/.local/bin/eza"

if ! command -v "$BINARY_PATH" &> /dev/null; then
    echo "$TOOL_NAME is not installed in $BINARY_PATH"
    read -p "Would you like to install it now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        bash "$DIR/install.sh"
    else
        return 1
    fi
fi

# Add ~/.local/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Set up alias for ls if not already set
if ! alias ls &> /dev/null; then
    alias ls="$BINARY_PATH"
fi

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# echo "$TOOL_NAME environment configured."
