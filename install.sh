#!/bin/sh

# Indicate bg process; command(s) are argument _________________________________ 
spinner() 
{
    "$@" &                                     #-- run arg in background
    x=1                                        #-- wind the ticker
    sp="/-\|"                                  #-- the spinner string
 
    tput civis
    while kill -0 $! 2>/dev/null; do           #-- until exit value emitted
        tput sc                                #-- save cursor position
        printf " ${sp:x++%${#sp}:1}";          #-- draw 1 char of $sp 
        tput rc                                #-- restore cursor position
        sleep 0.04                             #-- sleep 0.05s before looping
    done
    tput cnorm
}


# ovim "install" script.

CURRENT_DIR=`pwd`
DEFAULT_CFG="default.vimrc"

echo -n "Updating ovim submodules ..."

spinner git submodule --quiet init
spinner git submodule --quiet update

echo " done"

cat <<USAGE

This repository is designed to behave like a vim configuration 
directory. To use it, create the following symlinks:

        ln -s <THIS_DIRECTORY> ~/.vim
        ln -s <THIS_DIRECTORY>/$DEFAULT_CFG ~/.vimrc

If you wish to use your own .vimrc file, simply link against
that file instead of the included one.

USAGE

