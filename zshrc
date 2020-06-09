# ----------------------------------------------------------------------------
# NOTE: This will only work once the mac-config/install.sh has been run
# ----------------------------------------------------------------------------
#
# Path to your oh-my-zsh installation.
export ZSH=/Users/ben/.oh-my-zsh

# My custom theme
ZSH_THEME="bencd"

# oh-my-zsh plugins
plugins=(
    git 
    tmux 
    docker 
    docker-compose 
    vi-mode 
    kubectl 
    helm 
    django
    encode64
    arcanist
    autojump
)

source $ZSH/oh-my-zsh.sh

# Use homebrew installed bin
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/local/bin:$PATH
# Rust bin
export PATH=$HOME/.cargo/bin:$PATH
# Replaces BSD coreutils with GNU alternatives
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
# Android studio
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# Make python3.8 default python3
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Open ssl
export PATH="/usr/local/opt/openssl/bin:$PATH"

# GCP completion
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# Apple is deprecating SSL so homebrew doesn't add it to the library path by default, so manually patching here
#export LDFLAGS="-L/usr/local/opt/openssl/lib"
#export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# Python virtual env
export WORKON_HOME=~/dev/.venvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.8/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

export EDITOR=nvim

# Aliases
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias lg='lazygit'
alias vim='nvim'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
