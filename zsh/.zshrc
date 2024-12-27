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
path+=(/usr/local/go/bin) # manually installed go to get 1.22
path+=("${GOPATH}/bin")
path+=("$HOME/.rd/bin") # rancher desktop

path+=("${KREW_ROOT:-$HOME/.krew}/bin")
if [ $(uname -s) = 'Linux' ]; then
  # brew and aws cli
  path+=("$HOME/.local/bin")
  path+=("/var/lib/snapd/snap/bin")
else
  path+=("/opt/homebrew/opt/python/libexec/bin")
  path+=("/Users/zach.taylor/.local/bin")  # pipx binaries
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# }}}

# Plugins
# Much easier and faster to just clone these zsh plugins than use some crazy slow zsh plugin manager
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ ! -d ~/.zsh/fzf-tab ]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
fi
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
complete -o nospace -C /usr/local/bin/vault vault

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

# TODO: linux only
alias open=xdg-open

# fzf cd
alias cf="cd \$(find * -type d -not -path '.git*' | fzf || pwd)"

# reload
alias reload-zsh='source ~/.zshrc && echo "Zsh reloaded!"'
alias rz='reload-zsh'
alias rk='kitten @ load-config'

# editing configs
alias ez='vim ~/.zshrc'
alias ezl='vim ~/.config/shell/local.sh'
alias ek='vim ~/.config/kitty/kitty.conf'

# kitty
alias s='kitty +kitten ssh'

# ls
alias ls='ls -G'
alias la='ls -lah'
alias l.='ls -d .*'

# vim
alias vim='nvim'
alias vi='nvim'
alias nv="VIMRUNTIME=$HOME/code/neovim/runtime $HOME/code/neovim/build/bin/nvim" # Nightly neovim

# git
alias chat='gh copilot explain'
alias gp='git pull'
alias ghpr='gh pr create --draft'
alias ghprb='gh pr create --draft --body '
alias pr=ghprb
alias root='cd $(git rev-parse --show-toplevel)'
alias gl='git log'
# TODO: if no arg get via fzf
alias ga='git add'
alias gr='git reset'
alias gau='git add -u'
alias gan='git ls-files --others --exclude-standard | fzf --multi | xargs git add -N'
alias grn='git ls-files --others --exclude-standard | fzf --multi | xargs rm'
alias gap='git add --patch'
alias grp='git reset --patch'
alias gs='git status'
alias gsn='git status -uno'
alias gsh='git show'
alias gd='git diff'
alias gdw='git diff --word-diff=color --word-diff-regex=.'
alias gds='git diff --staged'
alias gdsw='git diff --staged --word-diff=color --word-diff-regex=.'
alias gco='git checkout'
alias gcom='git checkout $(git default-branch)'
alias gcm='git commit --message'
alias gca='git commit --amend --no-edit'
alias gcam='git commit --amend'
function gb() {
  branch=$(
    git branch --list --sort=-committerdate \
    | fzf \
        --header 'ctrl-r: remote | alt-l: local | alt-f: git-fetch' \
        --prompt='branch> ' \
        --bind='alt-l:change-prompt(local> )+reload(git branch --list --sort=-committerdate),ctrl-r:change-prompt(remote> )+reload(git branch --all --sort=-committerdate),alt-f:execute(git fetch)' \
  )

  if [ -n "$branch" ]; then
    tr -d ' *' <<< "$branch" \
    | awk '{gsub(/remotes\/origin\//,"");}1' \
    | xargs git checkout
  fi
}
alias gbm="git branch -m"
alias gf="git fetch"
alias gfp="git push --force-with-lease"
alias gfm='git fetch && git fetch origin :$(git default-branch)'
# TODO: just git continue, lookup what is currently in progress
alias grc="git rebase --continue"
alias gmc="git merge --continue"
alias gcpc="git cherry-pick --continue"
alias grom='git rebase origin/$(git default-branch) --autostash'
alias gri='git rebase -i'
alias gmom='git merge origin/$(git default-branch) --autostash'
alias grhm='git reset --hard origin/$(git default-branch)'
function grin() {
  git rebase --autostash -i "HEAD~$1"
}
alias gmt='git mergetool'

# ocaml
[[ ! -r /home/zach/.opam/opam-init/init.zsh ]] || source /home/zach/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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
alias docker=nerdctl

# Groups on lines
alias groups='groups | tr " " "\n"'

# aws
alias asl='aws sso login'
function asv() {
  if [ $(ast) = "null" ]; then
    echo 'error: aws sso session expired'
    return 1
  fi
  # echo "aws sso session valid"
}
alias ast="cat ~/.aws/sso/cache/* | jq -rs 'map(select(.accessToken and .expiresAt > (now | todate)) | .accessToken)[0]'"

# kubernetes
alias k=kubectl
if command -v kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi
# alias kubectx='kubectl ctx'
function kc() {
  asv || asl
  cluster=$(kubectl ctx | fzf)
  if [ "$cluster" = "" ]; then
    return
  fi
  k9s --context "$cluster"
}
function kn() {
  asv || asl
  cluster=$(kubectl ctx | fzf)
  if [ "$cluster" = "" ]; then
    printf "no clusters selected\n"
    return 1
  fi
  selection=$(kubectl --context $cluster get --no-headers namespaces > /dev/null | fzf)
  if [ "$selection" = "" ]; then
    printf "no namespace selected\n"
  fi
  namespace=$(awk '{ print $1 }' <<< "$selection")
  k9s --context "$cluster" --namespace "$namespace"
}
alias kcc='echo context: $(kubectl ctx -c) namespace: $(kubectl ns -c)'
alias kar='kubectl argo rollouts'
alias argo='argocd'

alias rg="rg --hidden --glob '!.git'"
# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --glob '!.git'"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias lb="liquibase"

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
else
  source /usr/share/fzf/shell/key-bindings.zsh
  source /usr/share/zsh/site-functions/fzf
fi
# https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# direnv
eval "$(direnv hook zsh)"
alias da="direnv allow"
alias de="direnv edit"

# restish
alias ish=restish

# }}}

# OS Specific / Load Other Files
# {{{

if [ $(uname -s) = 'Linux' ]; then
  configure_keyboard() {
    xset r rate 200 25
    setxkbmap -layout us -option ctrl:nocaps
    echo "Keyboard configured!"

  }
fi

source ~/.config/shell/local.sh
source ~/.config/shell/prompt.sh

# }}}

function jwt() {
  jq -R 'split(".") | .[1] | @base64d | fromjson'
}

export GPG_TTY=$(tty)

# zprof

_fzf_complete_echo() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}
