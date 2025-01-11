# TODO: linux only
alias open=xdg-open

# reload
alias reload-zsh='source ~/.zshrc && echo "Zsh reloaded!"'
alias rz='reload-zsh'
alias rk='kitten @ load-config'

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

# just
alias j=just

# ripgrep
alias rg="rg --hidden --glob '!.git'"

# nvm is terribly slow, so instead
# alias nvm="unalias nvm && source /opt/homebrew/opt/nvm/nvm.sh && nvm"
# alias yarn="unalias yarn && source /opt/homebrew/opt/nvm/nvm.sh && yarn"
# or, nvm's typical stupid slor loader:
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# devbox
alias b=devbox

function maybe_devbox() {
  if [ -f 'devbox.json' ]; then
    if [ "$DEVBOX_SHELL_ENABLED" != "1" ]; then
      devbox shell
    fi
  fi
}

precmd_functions+=(maybe_devbox)

# direnv
eval "$(direnv hook zsh)"
alias da="direnv allow"
alias de="direnv edit"

# jwt
function jwt() {
  jq -R 'split(".") | .[1] | @base64d | fromjson'
}

# zoxide
eval "$(zoxide init zsh)"
alias cd=z

# fzf
if [ $(uname -s) = 'Darwin' ]; then
  source ~/.fzf.zsh
else
  source /usr/share/fzf/shell/key-bindings.zsh
  source /usr/share/zsh/site-functions/fzf
fi
# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --glob '!.git'"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# restish
alias ish=restish

# docker
alias d='docker'
alias dc='docker compose'
alias n='nerdctl'
alias nc='nerdctl compose'
if [ $(uname -s) = 'Darwin' ]; then
  alias docker=nerdctl
fi

# ocaml
[[ ! -r /home/zach/.opam/opam-init/init.zsh ]] || source /home/zach/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# gpg
export GPG_TTY=$(tty)
