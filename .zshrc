# Config from zsh-newuser-install & compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt          \
  autocd        \
  beep          \
  extendedglob  \
  dotglob       \
  nomatch       \
  notify        \
  share_history \
  hist_ignore_dups # Remove consecutive duplication commands in history

bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/zach/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Plugins
# {{{
source "${HOME}/.zgen/zgen.zsh"


if ! zgen saved; then

  # specify plugins here
  zgen load zsh-users/zsh-autosuggestions
  zgen load Valiev/almostontop

  # generate the init script from plugins above
  zgen save
fi

# TODO: Needed on Linux?!?
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# }}}

# Key bindings
# {{{

bindkey "^a" vi-beginning-of-line
bindkey "^e" vi-end-of-line

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# }}}

# Functions
# {{{

function prependPath() {
  local path

  path=$1

  if [[ ":$PATH:" != *":$path:"* ]]; then
    PATH="$path:${PATH}"
  fi
}

function build() {
  local number="${1}"
  local slug="${2:-avant-basic}"

  curl -sH "Authorization: Bearer $BUILDKITE_TOKEN" \
    "https://api.buildkite.com/v2/organizations/avant/pipelines/${slug}/builds/${number}"
}

function tmux_project() (
  set -e
  if [[ -z "$1" ]] ; then
    echo 'Missing argument (project name)'
    exit 1
  fi
  local session
  session=$1
  if ! tmux has-session -t $session 2>/dev/null; then
    tmux new-session -d -s $session -c ~/code/$session
  fi
  tmux switch -t $session 2>/dev/null
  # Maybe creating 2 panes and starting vim in top?
)

# }}}

# Aliases
# {{{

# reload
alias reload='reload-zsh && reload-tmux'
alias reload-zsh='source ~/.zshrc && echo "Zsh reloaded!"'
alias rz='reload-zsh'
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

alias tp='tmux_project'

# git
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gcm='git commit --message'

# bundler/rails
alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'

# docker
alias dc='docker-compose'

# Groups on lines
alias groups='groups | tr " " "\n"'

# postgresql
alias pg='pg_ctl'

function pg-stop() {
  current_version=$(asdf current postgres | cut -f 1 -d ' ')

  case "$current_version" in
    9.6.*)
      pg -D /Users/ztaylo43/.asdf/installs/postgres/9.4.11/data stop
      ;;
    9.4.*)
      pg -D /Users/ztaylo43/.asdf/installs/postgres/9.6.10/data stop
      ;;
    *)
      echo "Unknown postgres version"
      ;;
  esac
}

# cat -> bat
alias cat='bat'

alias a='avant'

# }}}

# Tools
# {{{

# hub
eval "$(hub alias -s)"

# fzf
if [[ $(uname -s) == Linux ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
else
  source ~/.fzf.zsh
fi

export FZF_DEFAULT_COMMAND='ag --all-types --hidden -g ""' # Find hidden and non-git files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ag maybe?
# alias ag='ag --all-types --hidden'

# golang
export GOPATH="$HOME/go"
export MYGOPATH="$GOPATH/src/github.com/taylorzr"


path=("${GOPATH}/bin" '/Users/zachtaylor/Library/Python/3.7/bin' $path)
# prependPath "${GOPATH}/bin"

# direnv
eval "$(direnv hook zsh)"

# asdf
# source $HOME/.asdf/asdf.sh
# source $HOME/.asdf/completions/asdf.bash

# }}}

# Env
# {{{
export EDITOR=nvim
# }}}

# OS Specific Config
# {{{

if [ $(uname -s) = 'Linux' ]; then
  source ~/.config/shell/linux.sh
else
  source ~/.config/shell/osx.sh
fi

source ~/.config/shell/local.sh

source ~/.config/shell/prompt.sh

# }}}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

alias ts='tmux list-sessions | fzf | cut -d ':' -f 1 | xargs tmux switch-client -t'


function run-tests() {
  local current_directory
  current_directory="${PWD##*/}"

  if [ -z "$TEST_COMMAND" ]; then
    bundle exec rspec "$@"
  else
    eval "$TEST_COMMAND" "$@"
  fi
}

alias t='run-tests'

function gco() {
  git branch | fzf | xargs git checkout | cut -d ' ' -f 2
}

# Define env vars like `SOME_NAME_DB_URL='postgres://....'`
# You then get a prompt like `SOME_NAME@localhost > _`
function db() (
  local url_var prompt url
  if [ -z "$1" ]; then
    echo "Error: Database url is empty"
    exit 1
  fi

  env_match=$(env | grep _DB_URL | grep "$1")

  if [ -z "$env_match" ]; then
    echo "Error: Could not find env var named *_DB_URL, with value '$1'"
    exit 1
  fi

  url_var=$(echo "$env_match" | cut -d '=' -f 1)

  if [ "${url_var: -7}" != "_DB_URL" ]; then
    echo "Error: The env var '${url_var}' must end in _DB_URL to be used with this db function"
    exit 1
  fi

  prompt=$(echo $url_var | cut -d '=' -f 1 | sed 's/_DB_URL//g')
  url=$(print -rl -- ${(P)url_var})
  psql -v "prompt=$prompt" "$url"
)

fs() {
	local -r fmt='#{session_id}:|#S|(#{session_attached} attached)'
	{ tmux display-message -p -F "$fmt" && tmux list-sessions -F "$fmt"; } \
		| awk '!seen[$1]++' \
		| column -t -s'|' \
		| fzf -q '$' --reverse --prompt 'switch session: ' -1 \
		| cut -d':' -f1 \
		| xargs tmux switch-client -t
}

# TODO: Test with new install
if [ -z "$(ls ~/.tmux/plugins 2>/dev/null)" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# TODO:
#   - Don't hardcode switching between only 9.4 & 11.2
#   - Automatically determine currently install normal postgres version instead of hardcoding
function switch_postgres() (
  set -euo pipefail

  local to current
  to="$1"
  current=$(psql -V | cut -f 3 -d ' ' | cut -f 1,2 -d .)

  if [ "$to" = "$current" ]; then
    echo "Current postgres version is already $to"
    exit 1
  else
    echo "Switching postgres from $current to $to..."
    case "$to" in
      9.4)
        stop_postgres "$current"
        brew link postgresql@9.4 --force
        brew services start postgresql@9.4
        ;;
      9.6)
        stop_postgres "$current"
        brew link postgresql@9.6 --force
        brew services start postgresql@9.6
        ;;
      11.*)
        stop_postgres "$current"
        brew link postgres
        brew services start postgres
        ;;
      *)
        echo "I don't know how to switch to postgres $to :("
        exit 1
    esac
  fi
)

function stop_postgres() {
  local version
  version="$1"

  case "$version" in
    9.4)
      brew services stop postgresql@9.4 2>/dev/null || echo "postgresql@9.4 not running"
      brew unlink postgresql@9.4
      ;;
    9.6)
      brew services stop postgresql@9.6 2>/dev/null || echo "postgresql@9.6 not running"
      brew unlink postgresql@9.6
      ;;
    11.*)
      brew services stop postgresql 2>/dev/null || echo "postgresql not running"
      brew unlink postgresql
      ;;
    *)
      echo "I don't know how to stop postgres $version :("
      exit 1
  esac
}
