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

source ~/.config/shell/alias.sh

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
