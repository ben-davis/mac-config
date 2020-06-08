if ! [ -x "$(command -v brew)" ]; then
  echo "--------- Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! -d "~/.config" ] 
then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

echo "--------- Installing brew packages"
brew bundle install

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

