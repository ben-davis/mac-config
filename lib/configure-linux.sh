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
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

export FISH_BIN=/usr/bin/fish
export NVIM_BIN=/opt/nvim/bin/nvim

echo "Installation completed."
