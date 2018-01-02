#!/bin/bash

# Oh My Zsh (copy of online install script)
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Vim Undodir
mkdir ~/.vim/undo

# Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# TPM
git clone https://github.com/tmux-plugins/tpm /home/sun/.tmux/plugins/tpm
