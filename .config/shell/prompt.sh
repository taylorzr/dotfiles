function preexec() {
  timer_start=${timer_start:-$SECONDS}
}

function precmd() {
  local last_exit_code=$?

  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/%F{yellow}:\1%f/')
  local git_sha=$(git rev-parse --short HEAD 2> /dev/null)

  if [ $timer_start ]; then
    command_time=$(($SECONDS - $timer_start))
    unset timer_start
  fi

  PS1="%1d${git_branch}"
  postgres_version=$(psql -V | cut -f 3 -d ' ' | cut -f 1,2 -d .)
  RPROMPT="${command_time}s ${git_sha} 🐘 ${postgres_version}"

  if [ "${last_exit_code}" -ge 1 ]; then
    if [[ $(uname -s) == Linux ]]; then
      echo oops | espeak 2> /dev/null # TODO: Async here would be nice tho
    else
      # TODO: Async oops, meh this seems ok on osx
      say oops
    fi
    PS1+=" %F{red}:(%f "
    RPROMPT=" %F{red}Exit Code: ${last_exit_code}%f $RPROMPT"
  else
    PS1+=" %F{green}:)%f "
    tput bel
  fi
}

