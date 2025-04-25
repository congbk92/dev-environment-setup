#!/bin/bash

# Add ~/.local/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

#!/bin/bash

# Get absolute path of this script
current_file_path=$(realpath "$0")
ROOT_DIR=$(dirname "$current_file_path")

# echo "Sourcing configurations from $ROOT_DIR..."
find "$ROOT_DIR" -mindepth 2 -name ".git" -prune -o -name "source.sh" -type f -print0 | while IFS= read -r -d '' file; do
    source $file
done

# echo "✅ All configurations sourced"
