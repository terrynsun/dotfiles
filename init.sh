#!/bin/bash

# Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
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

# Gnome-terminal: set solarized
if [ ! -d gnome-terminal-colors-solarized ]; then
    git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git
fi

# Auto-install script
cd gnome-terminal-colors-solarized
echo "3
1
YES" | ./install.sh
cd ..
rm -rf gnome-terminal-colors-solarized

# Symlink all dotfiles
echo symlinking dotfiles...

./symlink.sh
