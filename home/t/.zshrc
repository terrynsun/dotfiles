# Load oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# INSTALL: run
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# - https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
plugins=(z sudo zsh-syntax-highlighting)
#zstyle :omz:plugins:ssh-agent agent-forwarding on

# Activate plugins
source $ZSH/oh-my-zsh.sh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# No incremental append for history
unsetopt INC_APPEND_HISTORY

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

# Print % at non-\n terminated lines. This is the default and walters unsets it.
unsetopt nopromptsp

# Print git branch in right prompt
setopt PROMPT_SUBST
rprompt() {
  br=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
  echo -n "%F{green}%~%f"
  [ -n "$br" ] && echo -n " %F{blue}$br%f"
}
export RPROMPT='$(rprompt)'

if [ -f $HOME/.aliases ]; then
  source $HOME/.aliases
fi

### Set path
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/bin/core_perl
export PATH=$PATH:/usr/local/bin/go/bin

export EDITOR=nvim

# Dircolors from gnome-terminal-colors-solarized
if [ -f ~/.dir_colors/dircolors ]; then
  eval `dircolors ~/.dir_colors/dircolors`
fi

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
