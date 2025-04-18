# Download the latest stable Go for Linux (x86-64)
wget "https://go.dev/dl/$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9.]+\.linux-amd64\.tar\.gz' | head -n 1)"

# Extract to ~/.local/go (or any dir in your home)
mkdir -p ~/.local
rm -rf ~/.local/go && tar -C ~/.local -xzf go*.tar.gz
rm go*.tar.gz*

# Add Go to PATH (add to ~/.bashrc, ~/.zshrc, or ~/.profile)
INSTALL_DIR="~/.local/go/bin"
if grep -q "export PATH=.*$INSTALL_DIR" ~/.zshrc; then
    echo "PATH already contains $INSTALL_DIR"
else
    echo "export PATH=\$PATH:${INSTALL_DIR}" >> ~/.zshrc
    echo "PATH updated in ~/.zshrc by append $INSTALL_DIR" 
    echo "run 'source ~/.zshrc' to take effective"
fi
