# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
#
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zach/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zach
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "Valiev/almostontop"
zplug "desyncr/auto-ls"
zplug "changyuheng/zsh-interactive-cd"
zplug "popstas/zsh-command-time" # Not working :(

zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

bindkey "^a" vi-beginning-of-line
bindkey "^e" vi-end-of-line
# End of lines configured by zach
