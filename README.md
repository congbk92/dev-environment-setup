# dev-environment-setup

This repository contains scripts and configuration files to set up a development environment from scratch.
Notes: It has been tested in Unbuntu 24.04 LTS only.

## Installation
1. [Install nerd font](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k)
2. Clone the repository and run the installation script:
```sh
git clone https://github.com/yourusername/dev-environment-setup.git
cd dev-environment-setup
./install.sh
```
3. Open ~/.zshrc,
    1. Update theme: find the line that sets `ZSH_THEME`, and change its value to "powerlevel10k/powerlevel10k".
    2. Add more plugin:
        1. Add zsh-autosuggestions: `git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
        2. Find the line that sets `plugins`, and update its value
4. `source ~/.zshrc` and enter prompt to config
