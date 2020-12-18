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
brew bundle install

if [ ! -x "$(command -v pod)" ]; then
  echo "--------- Installing cocoapods"
  sudo gem install cocoapods
fi

if [ ! -x "$(command -v yarn)" ]; then
  echo "--------- Installing yarn"
  npm install -g yarn
fi

if ! [ -z "${ZSH_NAME}" ]; then
  echo "--------- Setting default shell to zsh"
  chsh -s /usr/local/bin/zsh
fi

if ! [ -f ~/.fzf.zsh ]; then
  echo "--------- Install fzf key bindings and fuzzy completion"
  $(brew --prefix)/opt/fzf/install
fi

pip3 install virtualenv
pip3 install virtualenvwrapper

if [ ! -d ~/.config ]; then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "--------- Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "--------- Symlinking tmux.config"
ln -s -f ~/dev/git/mac-config/tmux.conf ~/.tmux.conf

if [ ! -d ~/.config/nvim ]; then
  echo "--------- Symlinking nvim config"
  ln -s -f ~/dev/git/mac-config/nvim ~/.config
fi

if [ ! -d ~/.config/tmuxinator ]; then
  echo "--------- Symlinking tmuxinator config"
  ln -s -f ~/dev/git/mac-config/tmuxinator ~/.config
fi

echo "--------- Symlinking git config"
ln -s -f ~/dev/git/mac-config/gitconfig ~/.gitconfig

echo "--------- Symlinking iTerm2 config"
ln -s -f ~/dev/git/mac-config/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

if [ ! -d ~/.oh-my-zsh ]; then
  echo "--------- Install oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "--------- Install oh-my-zsh plugin: zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo "--------- Symlinking zshrc"
ln -s -f ~/dev/git/mac-config/zshrc ~/.zshrc

echo "--------- Symlinking bencd oh-my-zsh theme"
ln -s -f ~/dev/git/mac-config/bencd.zsh-theme ~/.oh-my-zsh/themes/bencd.zsh-theme

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
