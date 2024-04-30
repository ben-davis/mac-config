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
    vi-mode 
    encode64
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

# Make brew clang default
export PATH="$(brew --prefix)/Cellar/llvm/17.0.6_1/bin:$PATH"

# Make node 12 the default
# NOTE: I don't know why I made node12 the default but it's wildly out of date.

# export PATH="$(brew --prefix)/opt/node@12/bin:$PATH"
# Poetry likes to install itself separately

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Open ssl
export PATH="$(brew --prefix)/opt/openssl/bin:$PATH"

# QT
export PATH="/opt/homebrew/opt/qt5/bin:$PATH"

# Go binaries
export PATH="~/dev/.go/bin:$PATH"

# Apple is deprecating SSL so homebrew doesn't add it to the library path by default, so manually patching here
#export LDFLAGS="-L$(brew --prefix)/opt/openssl/lib"
#export CPPFLAGS="-I$(brew --prefix)/opt/openssl/include"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/opt/openssl/lib/

# For:
# 1. pillow
# 2. nvui
# 3. openssl (so python postgres works)
export LDFLAGS="-L$(brew --prefix)/opt/zlib/lib -L$(brew --prefix)/opt/node@12/lib -L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/zlib/include -I$(brew --prefix)/opt/node@12/include -I$(brew --prefix openssl)/include"

# Disable brew autoupdating every time you run install
HOMEBREW_NO_AUTO_UPDATE=1

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
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

export PATH="$HOME/.poetry/bin:$PATH"

# Enables the ruby version manager
eval "$(rbenv init - zsh)"

# Use ruby homebrew by default (can be overridden with rebenv if necessary)
export PATH=/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Used by the spotify tmux plugin to make it use apple music
export MUSIC_APP="Music"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
