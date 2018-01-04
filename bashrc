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

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# https://github.com/tmux/tmux/wiki/FAQ Not 100% of 100% this shoud be set for
# all terminals, maybe just within tmux but let's try this first
export TERM='screen-256color'

export EDITOR='nvim'

export GOPATH="$HOME/go"
export MYGOPATH="$GOPATH/src/github.com/taylorzr"


# Prompt
  prompt_command() {
    local last_exit_code=$?

    # Save and reload the history
    history -a; history -c; history -r

    # NOTE: Colors need to be escaped with \[ & \] to allow bash to
    # calculate the length of the prompt correctly, and so wrap lines
    # correctly
    local red='\[\033[31m\]'
    local green='\[\033[32m\]'
    local yellow='\[\033[33m\]'
    local reset='\[\033[00m\]'

    local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')

    if [[ ! -z $(git status -s 2> /dev/null) ]]; then
      git_branch="${yellow}${git_branch}${reset}"
    fi

    PS1="\w${git_branch}"

    if [ "${last_exit_code}" -ge 1 ]; then
      if [[ $(uname -s) == Linux ]]; then
        echo oops | espeak 2> /dev/null
      else
        say oops
      fi
      PS1+=" ${red}:(${reset} "
    else
      PS1+=" ${green}:)${reset} "
    fi
  }

  export PROMPT_COMMAND=prompt_command

# Aliases do
  alias reload='source ~/.bash_profile'
  alias vim='nvim'
  alias vi='nvim'
  alias la='ls -la'

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
  alias rs='rails server'

  # Docker
  alias dc='docker-compose'

  # Heroku
  alias hrc='heroku run rails console'

  alias dock='xrandr --output DP1 --auto --output eDP1 --off'
  alias undock='xrandr --auto'
# end Aliases

# Env

# Path modifications
  if [[ $(uname -s) == Linux ]]; then
    export PATH=~/.local/bin:$PATH # aws cli
  else
    export PATH=~/Library/Python/2.7/bin:$PATH # aws cli
  fi

  export PATH=$PATH:~/go/bin # go binaries

# Tool configuration
  # chruby
  default_ruby=2.4

  if [[ $(uname -s) == Linux ]]; then
    source /usr/share/chruby/chruby.sh
    # NOTE: I believe setting a default ruby version needs to come before
    # the auto.sh so that the correct ruby version will be used
    chruby $default_ruby
    source /usr/share/chruby/auto.sh
  else
    source /usr/local/share/chruby/chruby.sh
    # NOTE: I believe setting a default ruby version needs to come before
    # the auto.sh so that the correct ruby version will be used
    chruby $default_ruby
    source /usr/local/opt/chruby/share/chruby/auto.sh
  fi

  # fzf
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Work configuration
[ -f ~/dotfiles/config/bash/avant ] && source ~/dotfiles/config/bash/avant

# Secrets
[ -f ~/dotfiles/secrets ] && source ~/dotfiles/secrets

# Git Completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/dotfiles/git-completion.bash
if [ -f ~/dotfiles/git-completion.bash ]; then
  source ~/dotfiles/git-completion.bash
fi
