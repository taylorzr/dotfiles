#!/usr/bin/env bash

echo 'true' > ~/.tmux/plugins/tmux-reaper/is_resurrecting
echo "$(date +%s) marked resurrecting true" >> ~/.tmux_log

# TODO: Might have to add a slight sleep after restore completes but before we say resurrecting is
# false
# (while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && sleep 60 && echo 'false' > ~/.tmux/plugins/tmux-reaper/is_resurrecting && echo "$(date +%s) marked resurrecting false" >> ~/.tmux_log; do
#   sleep 0.2
# done)&

(while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do
  sleep 0.2
done)&

echo "$(date +%s) starting tmux" >> ~/.tmux_log
tmux
