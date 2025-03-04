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
    neovim \
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
    dust \
    fish \
    starship

curl -sS https://starship.rs/install.sh | sh

export FISH_BIN=/usr/bin/fish

echo "Installation completed."
