# # If not running interactively, don't do anything
[[ $- != *i* ]] && return

function prependPath() {
  local path

  path=$1

  if [[ ":$PATH:" != *":$path:"* ]]; then
    PATH="$path:${PATH}"
  fi
}

# Source all other global config files, and OS dependent files
for file in ~/dotfiles/config/bash/*; do
  if [ ! -d "$file" ]; then
    source $file
  fi
done

if [[ $(uname -s) == Linux ]]; then
  for file in ~/dotfiles/config/bash/linux/*; do
    if [ ! -d "$file" ]; then
      source $file
    fi
  done
else
  for file in ~/dotfiles/config/bash/osx/*; do
    if [ ! -d "$file" ]; then
      source $file
    fi
  done
fi

# Bash Options
# https://github.com/tmux/tmux/wiki/FAQ Not 100% of 100% this shoud be set for
# all terminals, maybe just within tmux but let's try this first
export TERM='screen-256color'
# Using editor like this doesn't work with `pass` for example, why?!?
# export EDITOR='nvim -c \"set tw=0"'
export EDITOR='nvim'
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

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
