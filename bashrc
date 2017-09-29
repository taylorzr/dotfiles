# From dell xps arch setup
# # If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
# # >>> BEGIN ADDED BY CNCHI INSTALLER
# export BROWSER=/usr/bin/google-chrome-stable
# export EDITOR=/usr/bin/nvim
# # <<< END ADDED BY CNCHI INSTALLER

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Prompt
  prompt_command() {
    local last_exit_code=$?

    local red='\033[31m'
    local green='\033[32m'
    local yellow='\033[33m'
    local reset='\033[00m'

    local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')

    PS1="\w ${git_branch}"

    if [ "${last_exit_code}" -ge 1 ]; then
      # TODO: Is it bad to print or echo here? Something about bash PS1
      # length being off?!?
      # Hmn, still happening even though we're not echoing/printing :/
      PS1+=" ${red}:(${reset} "
    else
      PS1+=" ${green}:)${reset} "
    fi
  }

  export PROMPT_COMMAND=prompt_command
  export EDITOR='nvim'

# Aliases do
  alias reload='source ~/.bash_profile'
  alias vim='nvim'
  alias vi='nvim'

  # Tmux
  alias tl='tmux list-sessions'
  alias tk='tmux kill-session -t'
  alias td='tmux detach'
  alias ta='tmux attach || { (while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do sleep 0.2; done)& tmux ; }'

  # Git
  alias g='git'
  alias gs='git status'
  alias gd='git diff'
  alias gds='git diff --staged'
  alias ga='git add .'
  alias gcm='git commit --message'

  # Bundler/rails
  alias be='bundle exec'
  alias ber='bundle exec rspec'
  alias cber='BROWSER=chrome bundle exec rspec'
  alias rc='rails console'

  # Docker
  alias dc='docker-compose'

  alias taco='echo yes please'
# end Aliases

# Env

# Path modifications
  # TODO: Conditional based on OS (OSX vs Linux)
  export PATH=~/Library/Python/2.7/bin:$PATH # For aws cli

# Tool configuration
  # chruby
  if [[ $(uname -s) == Linux ]]; then
    source /usr/share/chruby/chruby.sh
    source /usr/share/chruby/auto.sh
  else
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/opt/chruby/share/chruby/auto.sh
  fi
  chruby 2.4

  # fzf
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Work configuration
[ -f ~/dotfiles/config/bash/avant ] && source ~/dotfiles/config/bash/avant

# Secrets
[ -f ~/dotfiles/secrets ] && source ~/dotfiles/secrets
