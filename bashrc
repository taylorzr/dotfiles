# From dell xps arch setup
# # If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source other files
source ~/dotfiles/config/bash/aliases
source ~/dotfiles/config/bash/prompt
source ~/dotfiles/secrets
[ -f ~/dotfiles/config/bash/avant ] && source ~/dotfiles/config/bash/avant

if [[ $(uname -s) == Linux ]]; then
  source $HOME/dotfiles/config/bash/linux
else
  source $HOME/dotfiles/config/bash/osx
fi

# options
# https://github.com/tmux/tmux/wiki/FAQ Not 100% of 100% this shoud be set for
# all terminals, maybe just within tmux but let's try this first
export TERM='screen-256color'
export EDITOR='nvim -c "set tw=0"'
export GOPATH="$HOME/go"
export MYGOPATH="$GOPATH/src/github.com/taylorzr"
export PATH=$PATH:~/go/bin # go binaries
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# hub
eval "$(hub alias -s)"

# fzf
source ~/.fzf.bash
