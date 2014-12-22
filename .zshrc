# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh
source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
fi

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# plugins=(git-extras tmux sudo)

# Autocompletion
autoload -U compinit
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
compinit -i -d "${ZSH_COMPDUMP}"

zstyle ':completion:*' menu select
setopt completealiases

# Set prompt style (walters)
autoload -Uz promptinit
promptinit
prompt walters

export EDITOR=vim
export CC=clang

# Add to path
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl
export PATH=$PATH:$HOME/.cabal/bin:$HOME/.gem/ruby/2.0.0/bin
export PATH=$PATH:$HOME/bin

# Auto-open tmux
if [[ -z $TMUX ]] ; then
  if [[ -z $(tmux list-sessions | grep main) ]] ; then
    tmux new-session -s main
  else
    session_id=$(date +%s | tail -c 6)
    tmux new-session -d -t main -s $session_id
    tmux new-window
    tmux attach-session -t $session_id
  fi
fi

if [[ -z $(tmux list-sessions | grep attached) ]]; then
  tmux kill-session -a
fi

# export TERM='rxvt-unicode-256color'
export TERM='screen-256color'
