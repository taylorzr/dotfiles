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

if [[ -f "$HOME/dotfiles/config/bash/local" ]]; then
  source $HOME/dotfiles/config/bash/local
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

# Colored man pages:
# http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;016m\E[48;5;220m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
