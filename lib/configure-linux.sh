#!/bin/bash

# Update package lists
sudo apt-get update

# Install packages
sudo apt-get install -y \
    autojump \
    bat \
    jq \
    git \
    git-delta \
    golang-go \
    htop \
    httpie \
    imagemagick \
    lsd \
    nmap \
    ripgrep \
    rsync \
    tmux \
    fd-find \
    fzf \
    fish \
    gh

# Install additional utilities and tools if available
sudo apt-get install -y \
    cloc \
    fish

# Install starship prompt
curl -sS -o install-starship.sh https://starship.rs/install.sh
sh install-starship.sh --force
rm install-starship.sh

# Install nvim for arm64 (will need to change if we want to support x86)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
tar -xzf ./nvim-linux-arm64.tar.gz 
sudo rm -rf /opt/nvim
sudo mv ./nvim-linux-arm64 /opt/nvim
rm -rf nvim-linux-arm64*

# Install treesitter
yarn global add tree-sitter-cli
sudo ln -s ~/.config/yarn/global/node_modules/.bin/tree-sitter /usr/local/bin/tree-sitter

export FISH_BIN=/usr/bin/fish
export NVIM_BIN=/opt/nvim/bin/nvim

echo "Installation completed."
