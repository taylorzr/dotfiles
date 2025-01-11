HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=nvim
bindkey -e
bindkey "^a" vi-beginning-of-line
bindkey "^e" vi-end-of-line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

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

autoload bashcompinit && bashcompinit
