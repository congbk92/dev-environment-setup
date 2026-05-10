#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "${GREEN}[✓]${NC} $*"; }
warn() { echo -e "${YELLOW}[!]${NC} $*"; }
step() { echo -e "\n${BOLD}==> $*${NC}"; }

# --- Devbox setup ---
step "Setting up devbox config..."
DEVBOX_DIR="$HOME/.local/share/devbox/global/default"
mkdir -p "$DEVBOX_DIR"
ln -sfnT "${ROOT_DIR}/devbox/devbox.json" "$DEVBOX_DIR/devbox.json"
ln -sfnT "${ROOT_DIR}/devbox/devbox.lock" "$DEVBOX_DIR/devbox.lock"
info "Symlinked devbox config"

devbox global install

# --- Component installers ---
step "Running component installers..."
while IFS= read -r -d '' script <&3; do
    dir="$(dirname "$script")"
    echo -e "\n${BOLD}--- $(basename "$dir") ---${NC}"
    (bash "$script") || warn "$(basename "$dir") installer failed (continuing)"
done 3< <(find "$ROOT_DIR" -mindepth 2 -name ".git" -prune -o -name "install.sh" -type f -print0 | sort -z)

# --- ~/.zshrc update ---
step "Updating ~/.zshrc..."
ZSHRC="$HOME/.zshrc"
DEVBOX_LINE='eval "$(devbox global shellenv)"'
ZSHRC_LINE="source ${ROOT_DIR}/zshrc.sh"
FZF_LINE='eval "$(fzf --zsh)"'

add_if_missing() {
    local line="$1"
    if grep -qF "$line" "$ZSHRC" 2>/dev/null; then
        warn "Already in ~/.zshrc: $line"
    else
        echo "$line" >> "$ZSHRC"
        info "Added to ~/.zshrc: $line"
    fi
}

read -rp "Automatically update ~/.zshrc? [y/N] " reply
if [[ "${reply,,}" == "y" ]]; then
    add_if_missing "$DEVBOX_LINE"
    add_if_missing "$ZSHRC_LINE"
    add_if_missing "$FZF_LINE"
else
    warn "Skipped ~/.zshrc update. Add the following lines manually:"
    echo "  $DEVBOX_LINE"
    echo "  $ZSHRC_LINE"
    echo "  $FZF_LINE"
fi

step "Installation complete! Run: source ~/.zshrc"
