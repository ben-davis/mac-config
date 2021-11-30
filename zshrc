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
    zsh-autosuggestions
    poetry
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
# Make brew python default
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# TEMP: Use 3.10 by default (until brew python default is upgraded to 3.10)
export PATH="/usr/local/opt/python@3.10/bin:$PATH"
# Contains symlinks for `python` (above has links for `python3`)
export PATH="/usr/local/opt/python@3.10/libexec/bin:$PATH"
# Make node 12 the default
export PATH="/usr/local/opt/node@12/bin:$PATH"
# Poetry likes to install itself separately

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

# For pillow to work
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# For nvui
export LDFLAGS="-L/usr/local/opt/node@12/lib"
export CPPFLAGS="-I/usr/local/opt/node@12/include"


# Python virtual env
export WORKON_HOME=~/dev/.venvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.8/bin/python3
source /usr/local/bin/virtualenvwrapper.sh


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `userpath` on 2020-11-16 23:04:15
export PATH="$PATH:/Users/ben/.local/bin"


source /Users/ben/.config/broot/launcher/bash/br

# Support neovim-remote to allow plugins to control neovim. Using it for lazygit inside neovim.
# NOTE: Not working atm, assuming because nvim5 isn't respecting server name configuration

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export EDITOR=nvim
    export VISUAL=nvim
fi


# Aliases
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias lg='lazygit'
alias vim='nvim'
alias ll='exa -l'
alias dc='docker-compose'

export PATH="$HOME/.poetry/bin:$PATH"
