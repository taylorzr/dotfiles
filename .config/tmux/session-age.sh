#!/bin/bash

set -euo pipefail

session_name=$(tmux display-message -p "#S")

echo "Switched to $session_name"

new="$session_name $(date +%s)"

echo "$new" >> ~/.tmux-log

# TODO: Consider swapping timestamp/name position so itd be easy to sort
if grep -q "$session_name " ~/.tmux-session-age; then
  sed -i '' "s/$session_name .*/$new/" ~/.tmux-session-age
else
  echo "$new" >> ~/.tmux-session-age
fi
