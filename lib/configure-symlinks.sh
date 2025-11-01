if [ ! -d ~/.config ]; then
  echo "--------- Making ~/.config"
  mkdir ~/.config
fi

echo "--------- Symlinking config.fish"
mkdir -p ~/.config/fish
ln -s -f ~/dev/git/mac-config/fish/config.fish ~/.config/fish/config.fish
ln -s -f ~/dev/git/mac-config/fish/fish_plugins ~/.config/fish/fish_plugins

echo "--------- Symlinking nvim config"
ln -s -f -n ~/dev/git/mac-config/nvim ~/.config

echo "--------- Symlinking bashrc"
ln -s -f ~/dev/git/mac-config/bashrc ~/.bashrc

echo "--------- Symlinking alacritty"
mkdir -p ~/.config/alacritty
ln -s -f ~/dev/git/mac-config/alacritty.toml ~/.config/alacritty/alacritty.toml

echo "--------- Symlinking ghostty"
mkdir -p ~/.config/ghostty
ln -s -f ~/dev/git/mac-config/ghostty.config ~/.config/ghostty/config

echo "--------- Symlinking yabai"
ln -s -f -n ~/dev/git/mac-config/yabai ~/.config/yabai

echo "--------- Symlinking sketchybar"
ln -s -f -n ~/dev/git/mac-config/sketchybar ~/.config/sketchybar

echo "--------- Symlinking skhdrc"
ln -s -f -n ~/dev/git/mac-config/skhd ~/.config/skhd

if [ -z "$SKIP_SYMLINK_GIT" ]; then
  echo "--------- Symlinking git config"
  ln -s -f ~/dev/git/mac-config/gitconfig ~/.gitconfig
fi

echo "--------- Symlinking tmux.conf"
ln -s -f ~/dev/git/mac-config/tmux.conf ~/.tmux.conf

echo "--------- Symlinking tmuxinator config"
ln -s -f -n ~/dev/git/mac-config/tmuxinator ~/.tmuxinator
