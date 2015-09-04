#!/bin/bash

# Oh My Zsh (copy of online install script)
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
