#!/bin/bash

INSTALL_DIR="${HOME}/.packages/lazygit/bin"
mkdir -p ${INSTALL_DIR}

DOWNLOAD_DIR="${HOME}/.packages/lazygit"
DOWNLOAD_PATH="${DOWNLOAD_DIR}/lazygit.tgz"

# Define the version you want to install
VERSION="0.48.0"
DOWNLOAD_URL=https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_Linux_x86_64.tar.gz

# Download the release package
wget -O ${DOWNLOAD_PATH} ${DOWNLOAD_URL}
# Extract the package
tar xvf ${DOWNLOAD_PATH} -C ${INSTALL_DIR}

if grep -q "export PATH=.*$INSTALL_DIR" ~/.zshrc; then
    echo "PATH already contains $INSTALL_DIR"
else
    echo "export PATH=\$PATH:${INSTALL_DIR}" >> ~/.zshrc
    echo "PATH updated in ~/.zshrc by append $INSTALL_DIR"
fi

