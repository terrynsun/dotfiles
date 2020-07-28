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
    if [ ! -f $target ] && [ -L $target ]; then
        rm $target
    fi

    # If the target file doesn't exist (is neither file nor directory)
    if [ ! -f $target ] && [ ! -d $target ]; then
        echo ln -s $(pwd)/$f $target
        ln -s $(pwd)/$f $target
    else
        echo "[$target] already linked, skipping"
    fi
done

# .local/bin is an exception: it _should_ link back to this repo, so I don't
# have to add each new script
if [ ! -f /home/t/.local/bin ] && [ ! -L /home/t/.local/bin ]; then
    echo ln -s $(pwd)/home/t/.local/bin /home/t/.local/bin
    ln -s $(pwd)/home/t/.local/bin /home/t/.local/bin
fi
