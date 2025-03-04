# Ensure:
# 1. You're authenticated with github
# 2. If you're on a prelease macOS, ensure that xcode command line beta tools are installed

set -e -o pipefail

if [ ! -d ~/dev/git ]; then
  echo "--------- Making ~/dev/git"
  mkdir -p ~/dev/git
fi

if [ ! -d ~/dev/git/mac-config ]; then
  echo "--------- Cloning mac-config"
  git clone "git@github.com:ben-davis/mac-config.git" ~/dev/git/mac-config
fi

case "$(uname -s)" in
    "Linux")
      source ./lib/configure-linux.sh
      ;;
    "Darwin")
      source ./lib/configure-mac.sh
      ;;
    *)
      echo "Unknown operating system: $OS_NAME. Cannot install."
      exit 1;
      ;;
esac

cd ~/dev/git/mac-config

echo "--------- Setting default shell to fish"
if ! grep -q $FISH_BIN /etc/shells ; then
   # APPEND TO /etc/shells
   echo $FISH_BIN  | sudo tee -a /etc/shells
fi

sudo chsh -s $FISH_BIN

echo "--------- Installing fish plugin manager"
$FISH_BIN -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

source ./lib/configure-symlinks.sh

echo "--------- Install fisher"
$FISH_BIN -c "fisher update"

echo "--------- Install neovim plugins"
$NVIM_BIN --headless +PlugInstall +qall

echo "--------- Reload shell"
exec $FISH_BIN -l

echo "Restart your machine to have the keyboard preferences take effect"

