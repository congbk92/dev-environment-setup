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

# Build file list using absolute paths
declare -a source_files
while IFS= read -r -d '' file; do
    # Convert to absolute path and add to array
    abs_path="$(cd "$(dirname "$file")" && pwd)/$(basename "$file")"
    source_files+=("$abs_path")
done < <(find "$ROOT_DIR" -mindepth 2 -name "source.sh" -type f -print0)

# Track sourced files to prevent recursion
declare -A sourced_files

for file in "${source_files[@]}"; do
    if [[ -f "$file" ]]; then
        # Skip if already sourced
        [[ -n "${sourced_files[$file]}" ]] && continue
        
        # echo "➜ Sourcing ${file#$ROOT_DIR/}"
        sourced_files["$file"]=1
        # Source with absolute path to prevent relative path issues
        source "$file"
    else
        echo "⚠️  File not found: ${file#$ROOT_DIR/}" >&2
    fi
done

# echo "✅ All configurations sourced"
