#!/usr/bin/env bash

sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:neovim-ppa/stable

sudo apt update
sudo apt -y install tmux
sudo apt -y install neovim
sudo apt -y upgrade
sudo apt autoremove
sudo apt clean

. nvim_setup.sh

cp -v .tmux.conf ~

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
