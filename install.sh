#!/usr/bin/env bash
set -euo pipefail

link() {
  mkdir -p "$(dirname "$2")"
  if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
    echo "Already linked: $2 -> $1"
  else
    [ -e "$2" ] && rm -rf "$2"
    ln -sf "$1" "$2"
    echo "Linked $1 -> $2"
  fi
}

# shell
link "$PWD"/fish/functions ~/.config/fish/functions
link "$PWD"/fish/config.fish ~/.config/fish/config.fish

# terms
link "$PWD"/ghostty ~/.config/ghostty

# editor
link "$PWD"/nvim ~/.config/nvim
link "$PWD"/zed/settings.json ~/.config/zed/settings.json
link "$PWD"/zed/keymap.json ~/.config/zed/keymap.json

# other
link "$PWD"/starship/starship.toml ~/.config/starship.toml
link "$PWD"/git/config ~/.config/git/config
link "$PWD"/git/gitignore ~/.config/git/ignore
link "$PWD"/bat/config ~/.config/bat/config
link "$PWD"/BeatPrints/config.toml ~/.config/BeatPrints/config.toml

if [[ $OSTYPE == 'darwin'* ]]; then
   brew bundle --file=$PWD/Brewfile
fi

# setup fish
if ! grep -q fish /etc/shells; then
    echo "Adding $(which fish) to /etc/shells - will ask for root password"
    which fish | sudo tee -a /etc/shells
fi
if [ $SHELL != $(which fish) ]; then
    echo "Setting $(which fish) as the default shell - will ask user password"
    chsh -s $(which fish)
fi

echo "[✔] Bootstrap complete. Restart your shell!"
