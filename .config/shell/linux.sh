# aws cli
prependPath "~/.local/bin"

# chruby
source /usr/share/chruby/chruby.sh
# NOTE: I believe setting a default ruby version needs to come before
# the auto.sh so that the correct ruby version will be used
chruby 2.4
source /usr/share/chruby/auto.sh

configure_keyboard() {
  xset r rate 200 25
  setxkbmap -layout us -option ctrl:nocaps
  echo "Keyboard configured!"

}
alias rk='configure_keyboard'

alias sys='systemctl'

# external monitor
alias dock='xrandr --output DP1 --auto --output eDP1 --off'
alias undock='xrandr --auto'

export BROWSER=/usr/bin/google-chrome-stable
