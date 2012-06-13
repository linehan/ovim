#!/bin/sh

# Pulls (git pull) the latest commit of the plugin repositories in 
# the ./repo directory.

cloneum()
{
        git clone https://github.com/scrooloose/nerdcommenter.git
        git clone https://github.com/scrooloose/nerdtree.git
        git clone https://github.com/godlygeek/tabular.git
}

if [ "$(ls -A ./repo 2>/dev/null)" ]; then
        for i in `find ./repo -maxdepth 1 -mindepth 1 -type d`; do
                cd $i
                [ "$(ls -A 2>/dev/null)" ] && git pull && cd - || echo ":-/"
        done
else
        cd ./repo && cloneum;
fi

