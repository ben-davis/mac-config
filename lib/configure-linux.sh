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
    gh

# Install additional utilities and tools if available
sudo apt-get install -y \
    cloc

# Install fish from source (apt version is typically outdated; fish 4.x requires Rust)
sudo apt-get install -y cmake libpcre2-dev gettext
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi
FISH_VERSION="4.6.0"
curl -LO "https://github.com/fish-shell/fish-shell/releases/download/${FISH_VERSION}/fish-${FISH_VERSION}.tar.xz"
tar -xf "fish-${FISH_VERSION}.tar.xz"
cd "fish-${FISH_VERSION}"
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
cmake --build . -j"$(nproc)"
sudo cmake --install .
cd ../..
rm -rf "fish-${FISH_VERSION}" "fish-${FISH_VERSION}.tar.xz"
if [ ! -f /usr/local/bin/fish ]; then
    echo "Error: fish was not installed successfully at /usr/local/bin/fish"
    exit 1
fi

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

export FISH_BIN=/usr/local/bin/fish
export NVIM_BIN=/opt/nvim/bin/nvim

echo "Installation completed."
