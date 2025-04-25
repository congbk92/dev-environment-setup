#!/bin/sh

# Check for existing Oh My Zsh installation
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed at ~/.oh-my-zsh"
  read -r -p "Would you like to reinstall? This will overwrite your existing installation. [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY])
      # Proceed with reinstall
      echo "Preparing to reinstall Oh My Zsh..."
      mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh.bk
      ;;
    *)
      echo "Installation cancelled."
      exit 0
      ;;
  esac
fi

# Main installation
setup_ohmyzsh() {
  # Download and run the official installer
  echo "Downloading Oh My Zsh installer..."
  env ZSH="$HOME/.oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # The installer will:
  # 1. Clone the repository (or update if existing)
  # 2. Backup existing zshrc
  # 3. Create new zshrc from template
  # 4. Handle all edge cases properly
  
  echo "Oh My Zsh has been installed!"
  
  # Install powerlevel10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

  #Install zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

}

setup_ohmyzsh
