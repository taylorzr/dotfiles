alias gs='git status'
alias gl='git log'
alias gs="git status"
alias ga="git add"
alias gap="git add --patch"
alias gd="git diff"
alias gds="git diff --staged"
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gco='git checkout'
alias gnb='git checkout -b'
alias gp='git push'
alias gf='git fetch'

alias good="git bisect good"
alias bad="git bisect bad"

alias be='bundle exec'
alias ber="bundle exec rspec"
alias berc="BROWSER=chrome ber"

alias rc="bundle exec rails console"
alias ukrc="RAILS_LOCALE=en-GB rc"
alias rs="bundle exec rails server"

alias dbr="RAILS_ENV=development be rake db:reset"
alias dbrt="RAILS_ENV=test be rake db:reset db:seed"
alias dbrab="be rake db:reset db:spec:seed"

alias hrc="heroku run rails console"
alias hl="heroku logs -t"
alias hr="heroku run"
alias hcs="heroku config:set"

alias post="curl -X POST -H Content-Type:application/json"

alias reload='reload_tmux; and reload_zsh'
alias reload_zsh='source ~/.zshrc; and echo Zsh config reloaded!'
alias reload_tmux='tmux source-file ~/.tmux.conf; and echo "Tmux config reloaded!"'

alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'

alias s='brew services'
alias sl='brew services list'

alias is='iex -S mix'

alias vim='nvim'

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish
# chruby 2.4 is this necessary?!?

# NOTE: Maybe this should only be executed once, and then its store in
# ~/.config/fish/fishd.a45e60bc9d05
# ? read docs on fish!!!
# NOTE: To add to path, do not add anything here
# Instead run this command in a fish shell:
# set --universal fish_user_paths $fish_user_paths <path/to/bin>
# e.g.
# set --universal fish_user_paths $fish_user_paths ~/Library/Python/2.7/bin
#
# TODO: How can I add this to my dotfiles?!?
# https://github.com/fish-shell/fish-shell/issues/527#issuecomment-253668636

function mfa
  set -e AWS_ACCESS_KEY_ID
  set -e AWS_SECRET_ACCESS_KEY
  set -e AWS_SESSION_TOKEN
  set -e AWS_SECURITY_TOKEN
  eval (python ~/.mfa.py $argv[1] $argv[2])
end

# eval (python -m virtualfish)
