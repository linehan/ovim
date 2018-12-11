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


if [ "$1" == "link" ]; then
	echo -n "Linking ovim submodules ..."
	spinner ln --symbolic --no-target-directory $CURRENT_DIR ~/.vim
	spinner ln --symbolic --no-target-directory $CURRENT_DIR/$DEFAULT_CFG ~/.vimrc
	echo " done"
	exit
fi

if [ "$1" == "update" ]
then
        echo -n "Updating ovim submodules in plugins-github/ ..."

        spinner git submodule --quiet init
        spinner git submodule --quiet update

        echo " done"

        exit
fi

if [ "$1" == "plugins" ]
then
        echo "Creating links to submodule plugins ..."

        for path in plugins-github/*; do
                name=$( basename $path )
                ln --symbolic --no-target-directory $CURRENT_DIR/$path bundle/$name && echo "Added bundle/$name"
        done

        echo "done"

        echo "Creating links to static plugins ..."

        for path in plugins-static/*; do
                name=$( basename $path )
                ln --symbolic --no-target-directory $CURRENT_DIR/$path bundle/$name && echo "Added bundle/$name"
        done

        echo "done"
        exit
fi

cat <<USAGE

This repository is designed to behave like a vim configuration
directory. To use it, create the following symlinks:

        ln -s <THIS_DIRECTORY> ~/.vim
        ln -s <THIS_DIRECTORY>/$DEFAULT_CFG ~/.vimrc

If you wish to use your own .vimrc file, simply link against
that file instead of the included one.

These links can be created automatically by running this install
script with the argument "link".

USAGE

