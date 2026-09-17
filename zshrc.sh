#!/bin/zsh

# Add ~/.local/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# ${(%):-%x}: prompt expansion %x gives the current sourced file name (reliable across all zsh contexts).
# :A resolves symlinks to absolute path; :h gives dirname. No subprocess.
ROOT_DIR="${${(%):-%x}:A:h}"

# Process substitution instead of a pipe, so `source` affects the current shell
# (a pipe would run the loop in a subshell). Sorted for deterministic load order.
while IFS= read -r -d '' file; do
    source "$file"
done < <(find "$ROOT_DIR" -mindepth 2 -name ".git" -prune -o -name "source.sh" -type f -print0 | sort -z)
