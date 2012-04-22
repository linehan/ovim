#!/bin/sh

# Pulls (git pull) the latest commit of the plugin repositories in 
# the ./repo directory.

for i in `find ./repo -maxdepth 1 -mindepth 1 -type d`; do
        cd $i
        git pull
        cd - 
done
