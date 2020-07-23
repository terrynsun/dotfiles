#!/bin/bash

files=$(find * -mindepth 2 -path 'home/t/.local/bin' -prune -o -print)
for f in $files; do
    target=/$f
    # Directories: don't symlink back to repo
    if [ -d $f ]; then
        # Make the target dir if it doesn't exist
        if [ ! -d $target ]; then
            mkdir $target
        fi
    fi

    # if the target file doesn't exist _and_ is a symlink (aka broken symlink),
    # remove it
    if [ ! -f $target ] && [ -h $target ]; then
        rm $target
    fi

    # If the target file doesn't exist (is neither file nor directory)
    if [ ! -f $target ] && [ ! -d $target ]; then
        ln -s $(pwd)/$f $target
    else
        echo "$target already exists"
    fi
done

# .local/bin is an exception: it _should_ link back to this repo
ln -s $(pwd)/home/t/.local/bin /home/t/.local/bin
