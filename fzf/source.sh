#!/bin/bash

if ! command -v fzf &> /dev/null; then
    echo "fzf could not be found. Would you like to install it? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        current_file_path=$(realpath "$0")
        root_path=$(dirname "$current_file_path")
        ${root_path}/install.sh
    fi
else
    # Auto-completion
    [[ $- == *i* ]] && source "$(which fzf)/../shell/completion.zsh" 2> /dev/null

    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    # -- Use fd instead of fzf --

    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    _fzf_compgen_path() {
      fd --hidden --exclude .git . "$1"
    }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
      fd --type=d --hidden --exclude .git . "$1"
    }
    source $HOME/.local/fzf-git/fzf-git.sh
    # echo "fzf is ready to use"
fi
