if ! [ -x "$(command -v brew)" ]; then
  echo "--------- Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "--------- Installing brew packages"
brew bundle install

if [ ! -d "~/dev/git" ] 
then
  echo "--------- Making ~/dev/git"
  mkdir -p ~/dev/git
fi

if [ ! -d "~/dev/git/mac-config" ] 
then
  echo "--------- Cloning mac-config"
  git clone "git@github.com:ben-davis/mac-config.git" ~/dev/git/mac-config
fi

cd ~/dev/git/mac-config

if [ ! -d "~/.config" ] 
then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

if [ ! -f "~/.tmux/plugins/tpm" ] 
then
  echo "--------- Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -f "~/.zshrc" ] 
then
  echo "--------- Symlinking zshrc"
  ln -s ~/Users/ben/git/mac-config/zshrc ~/.zshrc
fi

if [ ! -f "~/.tmux.conf" ] 
then
  echo "--------- Symlinking tmux.config"
  ln -s ~/Users/ben/git/mac-config/tmux.conf ~/.tmux.conf
fi

if [ ! -d "~/." ] 
then
  echo "--------- Symlinking nvim config"
  ln -s ~/Users/ben/git/mac-config/nvim ~/.config/
fi

echo "--------- Symlinking iTerm2 config"
ln -s ~/Users/ben/git/mac-config/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

echo "--------- Configuring macOS defaults"
echo "System Preferences > Dock: autohide dock"
defaults write com.apple.dock autohide -bool true

echo "System Preferences > Dock: size"
defaults write com.apple.dock tilesize -int 36

echo "System Preferences > Keyboard: set fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2

echo "System Preferences > Keyboard: set fast key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "System Preferences > Trackpad: tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

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

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done
