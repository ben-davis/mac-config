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
    fish

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

# Install github CLI
curl -LO https://github.com/cli/cli/releases/download/v2.67.0/gh_2.67.0_linux_amd64.tar.gz
tar -xzf ./gh_2.67.0_linux_amd64.tar.gz
sudo mv ./gh_2.67.0_linux_amd64/bin/gh /usr/local/bin/gh
rm -rf gh_2.67.0_linux_amd64*


export FISH_BIN=/usr/bin/fish
export NVIM_BIN=/opt/nvim/bin/nvim

echo "Installation completed."
