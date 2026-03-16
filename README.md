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

4. Enable devbox global package by add the following into `~/.zshrc`
```sh
eval "$(devbox global shellenv)"
```

5. Clone the repository and run the installation script:
```sh
git clone https://github.com/yourusername/dev-environment-setup.git
cd dev-environment-setup
./install.sh
```

6. Update ~/.zshrc as the ouput of the previous step.

7. `source ~/.zshrc` and enter prompt to config.

8. [Install nerd font](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)
