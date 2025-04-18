!#/bin/bash

INSTALL_DIR="${HOME}/.packages/fzf/bin"
mkdir -p ${INSTALL_DIR}

wget https://github.com/junegunn/fzf/releases/download/v0.61.1/fzf-0.61.1-linux_amd64.tar.gz

mkdir -p ~/.packages/fzf

tar -xf fzf-0.61.1-linux_amd64.tar.gz -C ${INSTALL_DIR}
rm fzf-0.61.1-linux_amd64.tar.gz

if grep -q "export PATH=.*$INSTALL_DIR" ~/.zshrc; then
    echo "PATH already contains $INSTALL_DIR"
else
    echo "export PATH=\$PATH:${INSTALL_DIR}" >> ~/.zshrc
    echo "PATH updated in ~/.zshrc by append $INSTALL_DIR"
fi

SOURCE_FZF="source <(fzf --zsh)"
if grep -q  ${SOURCE_FZF} ~/.zshrc; then
    echo "fzf already source"
else
    echo ${SOURCE_FZF} >> ~/.zshrc
    echo "~/.zshrc was updated by append $SOURCE_FZF"
fi

