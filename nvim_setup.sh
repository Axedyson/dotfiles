#!/usr/bin/env bash

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
cp -v vimrc ~/.vim
