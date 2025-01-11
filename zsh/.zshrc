# NOTE: To profile zsh load time uncomment this and the zprof at EOF
# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
# zmodload zsh/zprof

source ~/.config/shell/zsh.sh
source ~/.config/shell/path.sh
source ~/.config/shell/plugins.sh
source ~/.config/shell/oops.sh
source ~/.config/shell/tools.sh
source ~/.config/shell/git.sh
source ~/.config/shell/aws_k8s.sh
source ~/.config/shell/local.sh

# OS Specific / Load Other Files

if [ $(uname -s) = 'Linux' ]; then
  configure_keyboard() {
    xset r rate 200 25
    setxkbmap -layout us -option ctrl:nocaps
    echo "Keyboard configured!"

  }
fi

# completion

complete -C /opt/homebrew/bin/aws_completer aws
# FIXME
# complete -o nospace -C '/opt/homebrew/bin/restish completion zsh' restish
complete -o nospace -C /opt/homebrew/bin/vault vault

# zprof
