#!/bin/bash

set -euo pipefail

# TODO: Loop through all current sessions, not only sessions recorded in history file
while read session; do
  log=$(grep "$session " ~/.tmux-session-age || echo '')

  if [ -n "$log" ]; then
    timestamp=$(echo "$log" | cut -d ' ' -f 2)
    now=$(date +%s)
    age_seconds=$(expr $now - $timestamp)
    printf "%s: %s\n" "$session" "$age_seconds"
  else
    printf "%s: -\n" "$session"
  fi
done < <(tmux list-sessions -F '#{session_name}')

