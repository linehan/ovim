#!/bin/sh

# ovim "install" script.

git submodule init
git submodule update

[ -d ~/.vim ]  && echo "Directory ~/.vim exists." && exit
[ -d ~/.vimrc] && echo "File ~/.vimrc exists."    && exit

CURRENT_DIR=`pwd`
DEFAULT_CFG=hubert.vimrc

ln -s $CURRENT_DIR ~/.vim 
ln -s $CURRENT_DIR/$DEFAULT_CFG ~/.vimrc

echo "ALL OK."
