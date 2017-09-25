# Prompt
  # TODO: Document or split this up or something so it's understandable
  # https://coderwall.com/p/pn8f0g/show-your-git-status-and-branch-in-color-at-the-command-prompt
  # TODO: Get git status in the prompt, e.g. number of changed lines or
  # icon of additions/subtractions
  previous_result() {
    if [ $? -ne 0 ]; then
      echo ':( '
    fi
  }
  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }
  export PS1="\$(previous_result)\w\[\033[33m\] \$(parse_git_branch)\[\033[00m\] \$ "
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
  # TODO: Conditional based on OS (OSX vs Linux)
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
  chruby 2.4
  # fzf
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Work configuration
[ -f ~/dotfiles/config/bash/avant ] && source ~/dotfiles/config/bash/avant ]

# Secrets
[ -f ~/dotfiles/secrets ] && source ~/dotfiles/secrets ]
