# ----------------------------------------------------------------------------
# NOTE: This will only work once the mac-config/install.sh has been run
# ----------------------------------------------------------------------------
if status is-interactive
    # Add brew to the path
    eval "$(/opt/homebrew/bin/brew shellenv)"

    set brew_prefix = (brew --prefix)

    # Use homebrew installed bin
    fish_add_path \
        $brew_prefix/bin:$brew_prefix/sbin:$HOME/local/bin \
        # Rust bin
        $HOME/.cargo/bin \
        # Replaces BSD coreutils with GNU alternatives
        $brew_prefix/opt/coreutils/libexec/gnubin \
        # Make brew python default
        "$brew_prefix/opt/python/libexec/bin" \
        # Make brew clang default
        "$brew_prefix/Cellar/llvm/17.0.6_1/bin" \
        # Yarn
        "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin" \
        # Open ssl
        "$brew_prefix/opt/openssl/bin" \
        # QT
        "/opt/homebrew/opt/qt5/bin" \
        # Go binaries
        "~/dev/.go/bin" \
        # Haskell binaries
        "~/dev/.cabal/bin" \
        # Poetry globals (TODO: Check this is needed)
        "$HOME/.poetry/bin"

    # Apple is deprecating SSL so homebrew doesn't add it to the library path by default, so manually patching here
    set -x LDFLAGS "-L$brew_prefix/opt/openssl/lib"
    set -x CPPFLAGS "-I$brew_prefix/opt/openssl/include"
    set -x LIBRARY_PATH $brew_prefix/opt/openssl/lib/

    # For:
    # 1. pillow
    # 2. nvui
    # 3. openssl (so python postgres works)
    set -x LDFLAGS "-L$brew_prefix/opt/zlib/lib -L$brew_prefix/opt/node@12/lib -L$brew_prefix/opt/openssl/lib"
    set -x CPPFLAGS "-I$brew_prefix/opt/zlib/include -I$brew_prefix/opt/node@12/include -I$brew_prefix/opt/openssl/include"

    # Disable brew autoupdating every time you run install
    set -x HOMEBREW_NO_AUTO_UPDATE 1

    # Support neovim-remote to allow plugins to control neovim. Using it for lazygit inside neovim.
    # NOTE: Not working atm, assuming because nvim5 isn't respecting server name configuration

    # if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    #     alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
    #     set -x VISUAL "nvr -cc split --remote-wait +'set bufhidden=wipe'"
    #     set -x EDITOR "nvr -cc split --remote-wait +'set bufhidden=wipe'"
    # else
    #     set -x EDITOR nvim
    #     set -x VISUAL nvim
    # fi

    # Enables the ruby version manager
    eval "$(rbenv init - fish)"

    # Use ruby homebrew by default (can be overridden with rebenv if necessary)
    fish_add_path \
        /opt/homebrew/opt/ruby/bin \
        /opt/homebrew/lib/ruby/gems/3.1.0/bin \
        /opt/homebrew/lib/ruby/gems/3.2.0/bin

    set -x LDFLAGS "-L/opt/homebrew/opt/ruby/lib"
    set -x CPPFLAGS "-I/opt/homebrew/opt/ruby/include"

    # Used by the spotify tmux plugin to make it use apple music
    set -x MUSIC_APP "Music"

    set -x NVM_DIR "$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # . "$HOME/.asdf/asdf.sh"
    # . "$HOME/.asdf/completions/asdf.fish"

    # https://github.com/halostatue/fish-haskell
    # [ -f "/Users/ben/.ghcup/env" ] && . "/Users/ben/.ghcup/env" # ghcup-env

    set -x LEDGER_FILE /Users/ben/dev/git/ledger/all-years.journal

    # # Aliases
    abbr -a lg lazygit
    abbr -a vim nvim
    abbr -a ll lsd -l
    abbr -a dc docker-compose
    abbr -a tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale

    starship init fish | source
    direnv hook fish | source

    set fish_greeting
end
