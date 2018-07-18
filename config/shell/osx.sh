# aws cli
prependPath "/usr/local/bin/python"

# chruby
source /usr/local/share/chruby/chruby.sh
# NOTE: I believe setting a default ruby version needs to come before
# the auto.sh so that the correct ruby version will be used
chruby 2.3
source /usr/local/opt/chruby/share/chruby/auto.sh

alias sys='brew services'
