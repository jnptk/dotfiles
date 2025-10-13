#!/bin/bash
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
link "$PWD"/zsh/.zshrc ~/.config/zsh/.zshrc
link "$PWD"/zsh/.zshenv ~/.config/zsh/.zshenv
link "$PWD"/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
link "$PWD"/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
link "$PWD"/zsh/pure ~/.config/zsh/pure

# terms
link "$PWD"/ghostty ~/.config/ghostty

# ssh
link "$PWD"/ssh/allowed_signers ~/.ssh/allowed_signers

# editor
link "$PWD"/nvim ~/.config/nvim
link "$PWD"/zed/settings.json ~/.config/zed/settings.json
link "$PWD"/zed/keymap.json ~/.config/zed/keymap.json

# other
link "$PWD"/git/config ~/.config/git/config
link "$PWD"/git/gitignore ~/.config/git/ignore
link "$PWD"/bat/config ~/.config/bat/config

# set var according to os
if [[ $OSTYPE == 'darwin'* ]]; then
   ZSHENV_FILE="/etc/zshenv"
else
   ZSHENV_FILE="/etc/zsh/zshenv"
fi

# create zshenv file if not exists
if [ ! -f "$ZSHENV_FILE" ]; then
    echo "Creating $ZSHENV_FILE..."
	sudo touch "$ZSHENV_FILE"
else
    echo "$ZSHENV_FILE already exists"
fi

# add export ... if not already in file
if ! grep -q "^export ZDOTDIR=" "$ZSHENV_FILE"; then
    echo "Adding ZDOTDIR to $ZSHENV_FILE"
    echo "export ZDOTDIR=\"$HOME/.config/zsh\"" | sudo tee -a "$ZSHENV_FILE" >/dev/null
else
    echo "ZDOTDIR already set"
fi


echo "[✔] Bootstrap complete. Restart your shell!"
