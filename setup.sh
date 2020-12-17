#!/bin/bash

# TODO: Make the autoload and the colors vim files udateable using git!
# TODO: Make so line 16 doesn't add the lines more than once no matter how many times this script is run!

clear

sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt update
sudo apt install tmux
sudo apt install neovim
sudo apt upgrade

cat .bashrc >> ~/.bashrc

DIR=~/".vim/pack/default/start/vim-polyglot"
if [ -d "$DIR" ]; then
  git -C "$DIR" pull -v
else
  git clone -v https://github.com/sheerun/vim-polyglot.git "$DIR"
fi

cp -rv .vim/ ~
cp -v .tmux.conf ~
cp -rv .config/ ~
