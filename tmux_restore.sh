#!/usr/bin/env bash

(while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do
  sleep 0.2
done)&

tmux
