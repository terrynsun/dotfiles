#!/bin/bash

files=$@

for f in $files; do
    if [ ! -f $f ]; then
        echo [$f] is not a file, skipping
        continue
    fi

    dir=$(dirname $f)
    localdir="${dir:1}"
    base=$(basename $f)
    new_full_path=$(pwd)/$localdir/$base

    if [ -f $new_full_path ]; then
        echo [$f] already exists at $new_full_path, skipping
        continue
    fi

    if [ ! -d $localdir ]; then
        echo \> mkdir -p $localdir
        mkdir -p $localdir
    fi

    echo \> mv $f $localdir
    mv $f $localdir

    echo \> ln -s $new_full_path $f
    ln -s $new_full_path $f
done
