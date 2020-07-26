# NOTE: To profile zsh load time uncomment this and the zprof at EOF
# zmodload zsh/zprof

# Basic Config
# {{{

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=nvim
bindkey -e

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt          \
  beep          \
  autopushd     \
  extendedglob  \
  dotglob       \
  nomatch       \
  notify        \
  share_history \
  hist_ignore_space \
  hist_ignore_all_dups

autoload -Uz compinit
compinit

typeset -U path

export GOPATH="$HOME/go"

path+=('/usr/local/go/bin' "${GOPATH}/bin")

# Much easier and faster to just clone these zsh plugins than use some crazy slow zsh plugin manager
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# # TODO: Needed on Linux?!?
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

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
# alias ta='tmux attach || { (while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do sleep 0.2; done)& tmux ; }'
alias ta='tmux attach || ~/tmux_restore.sh'
alias tp='tmux_project'
alias ts='tmux list-sessions | fzf | cut -d ':' -f 1 | xargs tmux switch-client -t'

# git
alias g='git'
alias ga='git add'
alias gap='git add --patch'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gcm='git commit --message'
# TODO: Keep git and home aliases in sync
alias home="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias hs="home status"
alias hd="home diff"
alias hds="home diff --staged"
alias hcm="home commit --message"
alias hap="home add --patch"

# bundler/rails
alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'

# docker
alias dc='docker-compose'

# Groups on lines
alias groups='groups | tr " " "\n"'

# postgresql
function pg-stop() {
  current_version=$(asdf current postgres | cut -f 1 -d ' ')

  case "$current_version" in
    9.6.*)
      pg_ctl -D /Users/ztaylo43/.asdf/installs/postgres/9.4.11/data stop
      ;;
    9.4.*)
      pg_ctl -D /Users/ztaylo43/.asdf/installs/postgres/9.6.10/data stop
      ;;
    *)
      echo "Unknown postgres version"
      ;;
  esac
}

# Python
alias python='python3'
alias pip='pip3'

# }}}

# Tools
# {{{

# hub
eval "$(hub alias -s)"

# fzf
source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --all-types --hidden -g ""' # Find hidden and non-git files
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ag maybe?
# alias ag='ag --all-types --hidden'

# direnv
eval "$(direnv hook zsh)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
if [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]; then
  source /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
fi
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
if [ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]; then
  source /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
fi

# }}}

# OS Specific / Load Other Files
# {{{

if [ $(uname -s) = 'Linux' ]; then
  source ~/.config/shell/linux.sh
else
  source ~/.config/shell/osx.sh
fi

source ~/.config/shell/local.sh
source ~/.config/shell/functions.sh
source ~/.config/shell/prompt.sh

# }}}

# zprof
