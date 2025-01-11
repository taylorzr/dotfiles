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
