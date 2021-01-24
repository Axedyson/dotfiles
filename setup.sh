#!/usr/bin/env bash

clear

sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt update
sudo apt install tmux
sudo apt install neovim
sudo apt upgrade
sudo apt autoremove
sudo apt clean

DIR=~/".vim/pack/default/start/vim-polyglot"
if [ -d "$DIR" ]; then
  git -C "$DIR" pull -v
else
  git clone -v https://github.com/sheerun/vim-polyglot.git "$DIR"
fi

wget https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/onedark.vim
DIR=~/".vim/autoload"
mkdir -pv "$DIR" && mv -v onedark.vim "$DIR"

wget https://raw.githubusercontent.com/joshdick/onedark.vim/master/colors/onedark.vim
DIR=~/".vim/colors"
mkdir -pv "$DIR" && mv -v onedark.vim "$DIR"

cp -rv .config/ ~
cp -v .tmux.conf ~
cp -v vimrc ~/.vim

FILE=~/".bashrc"
while IFS= read -r LINE; do
  if [ -z "$LINE" ]; then
    echo "Skipping as this line is empty"
  elif ! grep -Fxq "$LINE" "$FILE"; then
    echo "$LINE" >> "$FILE"
  else
    echo "Skipping already present line: \"$LINE\""
  fi
done < .bashrc
