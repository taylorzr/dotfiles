# Config from zsh-newuser-install & compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt          \
  autocd        \
  beep          \
  extendedglob  \
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
    tmux new-session -d -s $session -c ~/$session
  fi
  tmux switch -t $session 2>/dev/null
  # Maybe creating 2 panes and starting vim in top?
)

# }}}

# Aliases
# {{{

alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# reload
alias reload='reload-bash && reload-tmux'
alias reload-bash='source ~/.bash_profile && echo "Bash reloaded!"'
alias rb='reload-bash'
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

# Groups on lines
alias groups='groups | tr " " "\n"'

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


path=("${GOPATH}/bin" $path)
# prependPath "${GOPATH}/bin"

# direnv
eval "$(direnv hook zsh)"

# asdf
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

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
