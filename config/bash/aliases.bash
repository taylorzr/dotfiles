# reload
alias reload='reload-bash && reload-tmux'
alias reload-bash='source ~/.bash_profile && echo "Bashrc reloaded!"'
alias rb='reload-bash'
alias reload-tmux='tmux source-file ~/.tmux.conf && echo "Tmux config reloaded!"'

# ls
alias ls='ls -G'
alias la='ls -lah'
alias l.='ls -d .*'

# vim
alias vim='nvim'
alias vi='nvim'

# tmux
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias td='tmux detach'
alias ta='tmux attach || { (while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do sleep 0.2; done)& tmux ; }'

function tmux_project() (
  set -e
  if [[ -z "$1" ]] ; then
    echo 'Missing argument (project name)'
    exit 1
  fi
  local session
  session=$1
  if ! tmux has-session -t $session 2>/dev/null; then
    tmux new-session -d -s $session -c ~/$session
  fi
  tmux switch -t $session 2>/dev/null
  # Maybe creating 2 panes and starting vim in top?
)

alias tp='tmux_project'

# git
alias g='git'
alias gl='git log'
alias ga="git add"
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add .'
alias gcm='git commit --message'

# bundler/rails
alias be='bundle exec'
alias ber='bundle exec rspec'
alias cber='BROWSER=chrome bundle exec rspec'
alias rc='rails console'
alias rs='rails server'
alias pr='pry-remote'

# docker
alias dc='docker-compose'

function docker-bash()(
  local image
  image=$1
  if [ -z "$image" ]; then
    echo "You must specify an image name as the first argument"
    exit 1
  fi
  docker run -it $image bash
)

alias db='docker-bash'

# heroku
alias hrc='heroku run rails console'
