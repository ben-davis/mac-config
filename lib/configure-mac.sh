if ! [ -x "$(command -v brew)" ]; then
  echo "--------- Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "--------- Installing brew packages"
export HOMEBREW_NO_AUTO_UPDATE=1
/opt/homebrew/bin/brew bundle install || true

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

export FISH_BIN=/opt/homebrew/bin/fish
export NVIM_BIN=/opt/homebrew/bin/nvim
