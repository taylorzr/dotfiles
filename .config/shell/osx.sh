# chruby
source /usr/local/share/chruby/chruby.sh
# NOTE: I believe setting a default ruby version needs to come before
# the auto.sh so that the correct ruby version will be used
chruby 2.6
source /usr/local/opt/chruby/share/chruby/auto.sh

# aws cli
# I think newer cli is in /usr/local/bin already on path
# path+=("/usr/local/bin/python")

# Needed?
# '/Users/zachtaylor/Library/Python/3.7/bin'
