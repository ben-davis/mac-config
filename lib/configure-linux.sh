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
    nmap \
    ripgrep \
    rsync \
    tmux \
    fd-find \
    fzf \
    fish

# Install additional utilities and tools if available
sudo apt-get install -y \
    cloc \
    fish

curl -sS -o install-starship.sh https://starship.rs/install.sh
sh install-starship.sh --force
rm install-starship.sh

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
tar -xzf ./nvim-linux-arm64.tar.gz 
sudo rm -rf /opt/nvim
sudo mv ./nvim-linux-arm64 /opt/nvim
rm -rf nvim-linux-arm64*

export FISH_BIN=/usr/bin/fish
export NVIM_BIN=/opt/nvim/bin/nvim

echo "Installation completed."
