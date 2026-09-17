# lgx — fuzzy-find a git repo and open it in lazygit.
# Self-installing: ensures the lgx script is symlinked into ~/.local/bin
# (the job of the former install.sh, now idempotent so a fresh clone works
# in the next shell), then binds Ctrl+G (overrides zsh's send-break default)
# and Alt+G (overrides zsh's get-line default). Dependencies (fzf, lazygit,
# git; fd optional): lgx --check

# Resolve this component's directory (prompt expansion in zsh, BASH_SOURCE in bash)
if [[ -n "${ZSH_VERSION:-}" ]]; then
  _lgx_dir="${${(%):-%x}:A:h}"
else
  _lgx_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
fi

[[ -x "$_lgx_dir/lgx" ]] || chmod +x "$_lgx_dir/lgx"
mkdir -p "$HOME/.local/bin"
if [[ "$(readlink -f "$HOME/.local/bin/lgx" 2>/dev/null)" != "$_lgx_dir/lgx" ]]; then
  ln -sf "$_lgx_dir/lgx" "$HOME/.local/bin/lgx"
fi
unset _lgx_dir

# Keybinding — only in interactive shells where lgx is reachable
if [[ $- != *i* ]] || ! command -v lgx >/dev/null 2>&1; then
  return
fi

if [[ -n "${ZSH_VERSION:-}" ]]; then
  _lgx_widget() {
    lgx
    zle reset-prompt
  }
  zle -N _lgx_widget
  bindkey '^G' _lgx_widget     # Ctrl+G — single press
  bindkey '^[g' _lgx_widget    # Alt+G  — single press
elif [[ -n "${BASH_VERSION:-}}" ]]; then
  bind -m emacs-standard -x '"\C-g": lgx'
  bind -m vi-insert -x '"\C-g": lgx'
  bind -m emacs-standard -x '"\eg": lgx'
  bind -m vi-insert -x '"\eg": lgx'
fi
