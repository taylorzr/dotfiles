# NOTE: To profile zsh load time uncomment this and the zprof at EOF
# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
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
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# }}}

# Path
# {{{

export GOPATH="$HOME/go"
path+=('/usr/local/go/bin') # not sure i need this? no dir even on mac
path+=("${GOPATH}/bin")
path+=("$HOME/.rd/bin") # rancher desktop

if [ $(uname -s) = 'Linux' ]; then
  # brew and aws cli
  path+=('/home/linuxbrew/.linuxbrew/bin' '~/.local/bin')
else
  path+=("/opt/homebrew/opt/python/libexec/bin") # FIXME prolly should use a python version manager
  path+=("/Users/zach.taylor/Library/Python/3.10/bin") # FIXME prolly should use a python version manager
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# }}}

# Plugins
# {{{
# Much easier and faster to just clone these zsh plugins than use some crazy slow zsh plugin manager
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


autoload bashcompinit && bashcompinit

# FIXME: Not working on m1
# if [ ! -d ~/.zsh/fzf-tab-completion ]; then
#   git clone https://github.com/lincheney/fzf-tab-completion.git ~/.zsh/fzf-tab-completion
# fi
# source ~/.zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh
# bindkey '^I' fzf_completion

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

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# }}}

# Aliases
# {{{

# reload
alias reload-zsh='source ~/.zshrc && echo "Zsh reloaded!"'
alias rz='reload-zsh'

# editing configs
alias ez='vim ~/.zshrc'
alias ezl='vim ~/.config/shell/local.sh'
alias ek='vim ~/.config/kitty/kitty.conf'

# ls
alias ls='ls -G'
alias la='ls -lah'
alias l.='ls -d .*'

# vim
alias vim='nvim'
alias vi='nvim'
alias nv="VIMRUNTIME=$HOME/code/neovim/runtime $HOME/code/neovim/build/bin/nvim" # Nightly neovim

# git
alias root='cd $(git rev-parse --show-toplevel)'
alias gl='git log'
# TODO: if no arg get via fzf
alias ga='git add'
alias gna='git ls-files --others --exclude-standard | fzf --multi | git add'
alias gnr='git ls-files --others --exclude-standard | fzf --multi | xargs rm'
alias gap='git add --patch'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcm='git commit --message'
alias gca='git commit --amend --no-edit'
alias gcam='git commit --amend'
alias gb="git branch --all --sort=-committerdate | fzf | tr -d ' *' | awk '{gsub(/remotes\/origin\//,\"\");}1' | xargs git checkout"
alias gf="git fetch origin :$(git default-branch)"
alias grc="git rebase --continue"

# dotfiles are bare repo, so this makes git work in home dir
function git() {
  if [ "$PWD" = "$HOME" ] && [ "$1" != "clone" ]; then
    command git --git-dir="$HOME/dotfiles" --work-tree="$HOME" "$@"
  else
    command git "$@"
  fi
}

# ruby
alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias ber='bundle exec rspec'

# Terraform
alias tf='terraform'

# "Docker"
alias d='docker'
alias dc='docker compose'
alias n='nerdctl'
alias nc='nerdctl compose'

# Groups on lines
alias groups='groups | tr " " "\n"'

# Kubernetes
alias k=kubectl
function kk() {
  local cluster
  cluster="$1"

  if [ "$cluster" = "" ]; then
    cluster=$(kubectx | fzf)
  fi

  k9s --context "$cluster"
}
alias kc=kubectx
alias kcc='echo context: $(kubectx -c) namespace: $(kubens -c)'
alias kn=kubens
alias kar='kubectl argo rollouts'
alias argo='argocd'

alias rg="rg --hidden --glob '!.git'"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# nvm is terribly slow, so instead
# alias nvm="unalias nvm && source /opt/homebrew/opt/nvm/nvm.sh && nvm"
# alias yarn="unalias yarn && source /opt/homebrew/opt/nvm/nvm.sh && yarn"
# or, nvm's typical stupid slor loader:
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# }}}

# Tools
# {{{

# fzf
if [ $(uname -s) = 'Darwin' ]; then
  source ~/.fzf.zsh
fi
# fzf default command
# prefer git ls-tree/ls-files, then ag, then find if needed
# cat'ing ls-tree and ls-files because ls-tree doesn't know about 
# untracked files
# -- https://gist.github.com/bspaulding/387551e496b545df25fba23457860f64

# FIXME: Trying to get home dir working but no luck so far
# export FZF_DEFAULT_COMMAND='
# 	( { home ls-tree -r --name-only HEAD ; home ls-files ~ --exclude-standard } ||
#         { git ls-tree -r --name-only HEAD ; git ls-files . --exclude-standard --others } ||
# 		ag -g "" --ignore node_modules --ignore .terraform ||
# 		find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
# 		sed s/^..//
#     ) 2> /dev/null'

# ag maybe?
# alias ag='ag --all-types --hidden'

# direnv
eval "$(direnv hook zsh)"
alias da="direnv allow"

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
  configure_keyboard() {
    xset r rate 200 25
    setxkbmap -layout us -option ctrl:nocaps
    echo "Keyboard configured!"

  }
  alias rk='configure_keyboard'
else
  # path+=("$HOME/Library/Python/3.10/bin")
fi

source ~/.config/shell/local.sh
source ~/.config/shell/functions.sh
source ~/.config/shell/prompt.sh

# }}}

# TODO: Steal this cd function
# https://github.com/natw/dotfiles/blob/master/zsh/fzf.zsh#L17-L26

function jwt() {
  jq -R 'split(".") | .[1] | @base64d | fromjson'
}

export GPG_TTY=$(tty)

# Better shell history
# eval "$(atuin init zsh --disable-up-arrow)"  # FIXME: disable up arrow not working
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' _atuin_search_widget


# zprof
