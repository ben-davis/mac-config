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
/opt/homebrew/bin/brew bundle install

echo "--------- Setting default shell to zsh"
if ! grep -q "/opt/homebrew/bin/zsh" /etc/shells ; then
   # APPEND TO /etc/shells
   sudo echo "/opt/homebrew/bin/zsh" >> /etc/shells
fi
chsh -s /opt/homebrew/bin/zsh

if ! [ -f ~/.fzf.zsh ]; then
  echo "--------- Install fzf key bindings and fuzzy completion"
  $(brew --prefix)/opt/fzf/install
fi

if [ ! -d ~/.config ]; then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

if [ ! -d ~/.config/nvim ]; then
  echo "--------- Symlinking nvim config"
  ln -s -f ~/dev/git/mac-config/nvim ~/.config
fi

echo "--------- Symlinking zshrc"
ln -s -f ~/dev/git/mac-config/zshrc ~/.zshrc

echo "--------- Symlinking alacritty"
mkdir -p ~/.config/alacritty
ln -s -f ~/dev/git/mac-config/alacritty.yml ~/.config/alacritty/alacritty.yml

if [ ! -d ~/.oh-my-zsh ]; then
  echo "--------- Install oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "--------- Install oh-my-zsh plugin: zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo "--------- Symlinking bencd oh-my-zsh theme"
ln -s -f ~/dev/git/mac-config/bencd.zsh-theme ~/.oh-my-zsh/themes/bencd.zsh-theme

echo "--------- Source .zshrc"
source ~/.zshrc

echo "--------- Installing global Python packages"
pip install -r ./requirements.txt

echo "--------- Symlinking git config"
ln -s -f ~/dev/git/mac-config/gitconfig ~/.gitconfig

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
defaults write NSGlobalDomain InitialKeyRepeat -int 15

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
