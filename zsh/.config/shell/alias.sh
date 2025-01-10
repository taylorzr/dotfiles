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
if [ $(uname -s) = 'Darwin' ]; then
  alias docker=nerdctl
fi

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

# nvm is terribly slow, so instead
# alias nvm="unalias nvm && source /opt/homebrew/opt/nvm/nvm.sh && nvm"
# alias yarn="unalias yarn && source /opt/homebrew/opt/nvm/nvm.sh && yarn"
# or, nvm's typical stupid slor loader:
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

alias j=just
