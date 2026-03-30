#!/bin/bash

function symlink() {
    source=$1
    target=$2

    # Make directories, but don't link them.
    if [ -d $source ]; then
        # Make the target dir if it doesn't exist
        if [ ! -d $target ]; then
            echo \> mkdir $target
            mkdir $target
        else
            echo "[$target] directory exists"
        fi
    else
        # If the target file appears to be a broken symlink (is a symlink but
        # the file doesn't exist), remove it.
        if [ ! -e $target ] && [ -h $target ]; then
            echo "[$target] appears broken, removing..."
            rm $target
        fi

        # If the target file doesn't exist, link it.
        if [ ! -f $target ] && [ ! -d $target ]; then
            echo \> ln -s $(pwd)/$source $target
            ln -s $(pwd)/$source $target
        else
            echo "[$target] already linked, skipping"
        fi
    fi
}

# Symlink configuration files
cd config
files=$(find .)
for f in $files; do
    target=$HOME/$f
    symlink $f $target
done

cd ..

# Entire scripts directory gets symlinked back to this repo (so I don't have to
# link when writing new scripts).
rm $HOME/.local/bin
ln -s localbin $HOME/.local/bin
