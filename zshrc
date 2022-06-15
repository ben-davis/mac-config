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

# Add brew to the path
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use homebrew installed bin
export PATH=$(brew --prefix)/bin:$(brew --prefix)/sbin:$HOME/local/bin:$PATH
# Rust bin
export PATH=$HOME/.cargo/bin:$PATH
# Replaces BSD coreutils with GNU alternatives
export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH
# Make brew python default
export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"
# TEMP: Use 3.10 by default (until brew python default is upgraded to 3.10)
export PATH="$(brew --prefix)/opt/python@3.10/bin:$PATH"
# Contains symlinks for `python` (above has links for `python3`)
export PATH="$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH"
# Make node 12 the default
# NOTE: I don't know why I made node12 the default but it's wildly out of date.
# export PATH="$(brew --prefix)/opt/node@12/bin:$PATH"
# Poetry likes to install itself separately

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Open ssl
export PATH="$(brew --prefix)/opt/openssl/bin:$PATH"

# Apple is deprecating SSL so homebrew doesn't add it to the library path by default, so manually patching here
#export LDFLAGS="-L$(brew --prefix)/opt/openssl/lib"
#export CPPFLAGS="-I$(brew --prefix)/opt/openssl/include"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/opt/openssl/lib/

# For pillow to work
export LDFLAGS="-L$(brew --prefix)/opt/zlib/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/zlib/include"

# For nvui
export LDFLAGS="-L$(brew --prefix)/opt/node@12/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/node@12/include"

# Disable brew autoupdating every time you run install
HOMEBREW_NO_AUTO_UPDATE=0

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `userpath` on 2020-11-16 23:04:15
export PATH="$PATH:/Users/ben/.local/bin"

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
alias lg='lazygit'
alias vim='nvim'
alias ll='exa -l'
alias dc='docker-compose'

export PATH="$HOME/.poetry/bin:$PATH"
