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
profile=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[]\',")
echo $profile
gnome-terminal-colors-solarized/install.sh -s light -p $profile
exit

# Symlink all dotfiles
echo symlinking dotfiles...

./symlink.sh
