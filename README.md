# dev-environment-setup

This repository contains scripts and configuration files to set up a development environment from scratch.
Notes: It has been tested in Unbuntu 24.04 LTS and 22.04 LTS only.

## Installation
1. [Install Nix Package Manager](https://nixos.org/download/)
```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

2. [Install devbox](https://www.jetify.com/docs/devbox/installing-devbox)
```sh
curl -fsSL https://get.jetify.com/devbox | bash
```

3. Install zsh.
```sh
sudo apt install zsh
```

4. Clone the repository and run the installation script:
```sh
git clone https://github.com/congbk92/dev-environment-setup.git
cd dev-environment-setup
./install.sh
```

5. `source ~/.zshrc` and enter prompt to config.

6. [Install nerd font](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)

## WezTerm
The repo config (`wezterm/wezterm.lua`) is the single source of truth in both setups:

- **Windows + WSL**: install WezTerm on Windows, then run `./install.sh` from WSL. It writes a small bootstrap file to `%USERPROFILE%\.config\wezterm\wezterm.lua` that loads the repo config over the WSL UNC path. No admin or Developer Mode needed.
- **Native Linux**: install WezTerm yourself, then run `./install.sh`. It symlinks `~/.config/wezterm/wezterm.lua` to the repo config (an existing real file there is left untouched).
