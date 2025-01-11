# NOTE: Seems like oops must run within precmd
# Adding it to precmd_functions means it runs after something else that clears last exit code
function precmd() {
  local last_exit_code=$?

  if [ "${last_exit_code}" -ge 1 ]; then
    if [ -f "$OOPS_FILE" ]; then
      say oops
    fi
  fi
}

function say() {
  phrase="${1:-oops}"
  if [[ $(uname -s) == Linux ]]; then
    eval "$(<<< "$phrase" espeak 2>&1 > /dev/null &)"
  else
    command say "$phrase"
  fi
}

export OOPS_FILE="$HOME/.oops"

function oops_toggle() {
  if [ -f "$OOPS_FILE" ]; then 
    rm "$OOPS_FILE"
    say 'oops disabled'
  else
    touch "$OOPS_FILE"
    say 'oops enabled'
  fi
}
