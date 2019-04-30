#!/bin/bash

# Oh My Zsh (copy of online install script)
if [ ! -d ~/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
    echo oh-my-zsh already installed
fi

# Vim Undodir
mkdir -p ~/.vim/undo

# Vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
else
    echo vundle already installed
fi

# TPM
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo tpm already installed
fi

# Symlink all dotfiles
cd home

for f in $(ls -A); do
    # if file does not exist
    if [ ! -f ~/$f ] && [ ! -d ~/$f ]; then
        ln -s $(pwd)/$f ~/$f
    fi
done
