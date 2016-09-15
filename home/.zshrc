### zsh configuration

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

plugins=(z sudo)

# Activate plugins
source $ZSH/oh-my-zsh.sh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

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

if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
fi

### Set path
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/bin/core_perl
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin

# Have bundler install to ~/.gem/ruby/2.3.0/bin
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

export EDITOR=vim
#export CC=clang

### Auto-open tmux
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

# # OPAM configuration
# . /home/sun/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# eval `opam config env`
