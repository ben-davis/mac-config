# Ensure:
# 1. You're authenticated with github
# 2. If you're on a prelease macOS, ensure that xcode command line beta tools are installed

set -e -o pipefail

if ! [ -x "$(command -v brew)" ]; then
  echo "--------- Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! -d ~/dev/git ]; then
  echo "--------- Making ~/dev/git"
  mkdir -p ~/dev/git
fi

if [ ! -d ~/dev/git/mac-config ]; then
  echo "--------- Cloning mac-config"
  git clone "git@github.com:ben-davis/mac-config.git" ~/dev/git/mac-config
fi

cd ~/dev/git/mac-config

echo "--------- Installing brew packages"
export HOMEBREW_NO_AUTO_UPDATE=1
/opt/homebrew/bin/brew bundle install || true

echo "--------- Setting default shell to fish"
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells ; then
   # APPEND TO /etc/shells
   echo "/opt/homebrew/bin/fish"  | sudo tee -a /etc/shells
fi

echo "--------- Installing fish plugin manager"
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

chsh -s /opt/homebrew/bin/fish

echo "--------- Symlinking config.fish"
mkdir -p ~/.config/fish
ln -s -f ~/dev/git/mac-config/fish/config.fish ~/.config/fish/config.fish
ln -s -f ~/dev/git/mac-config/fish/fish_plugins ~/.config/fish/fish_plugins

echo "--------- Install fisher"
/opt/homebrew/bin/fish -c "fisher update"

if [ ! -d ~/.config ]; then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

if [ ! -d ~/.config/nvim ]; then
  echo "--------- Symlinking nvim config"
  ln -s -f ~/dev/git/mac-config/nvim ~/.config
fi

echo "--------- Symlinking alacritty"
mkdir -p ~/.config/alacritty
ln -s -f ~/dev/git/mac-config/alacritty.toml ~/.config/alacritty/alacritty.toml

echo "--------- Symlinking yabai"
ln -s -f ~/dev/git/mac-config/yabai ~/.config/yabai

echo "--------- Symlinking sketchybar"
ln -s -f ~/dev/git/mac-config/sketchybar ~/.config/sketchybar

echo "--------- Symlinking skhdrc"
ln -s -f ~/dev/git/mac-config/skhd ~/.config/skhd

echo "--------- Symlinking git config"
ln -s -f ~/dev/git/mac-config/gitconfig ~/.gitconfig

echo "--------- Symlinking tmux.conf"
ln -s -f ~/dev/git/mac-config/tmux.conf ~/.tmux.conf

echo "--------- Symlinking tmuxinator config"
ln -s -f ~/dev/git/mac-config/tmuxinator ~/.tmuxinator

echo "--------- Configuring macOS defaults"
echo "System Preferences > Dock: autohide dock"
defaults write com.apple.dock autohide -bool true

echo "System Preferences > Dock: size"
defaults write com.apple.dock tilesize -int 36

echo "System Preferences > Keyboard: set fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 1

echo "System Preferences > Keyboard: set fast key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 20

echo "System Preferences > Keyboard: disable press and hold"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "System Preferences > Trackpad: tap to click"
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "System Preferences > Trackpad: speed"
defaults write -g com.apple.trackpad.scaling -float 1.5

echo "System Preferences > Accessibility > Mouse & Trackpad: three finger drag"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

echo "System Preferences > Mission Control: Automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "Finder > Preferences: Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder > Preferences: Show warning before changing an extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Finder > View: Show Path Bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder: Disable finder"
defaults write com.apple.finder CreateDesktop -bool false

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

echo "--------- Reload shell"
exec /opt/homebrew/bin/fish -l

echo "Restart your machine to have the keyboard preferences take effect"

