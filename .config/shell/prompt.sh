function preexec() {
  timer_start=${timer_start:-$SECONDS}
}

function precmd() {
  local last_exit_code=$?

  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  local git_sha=$(git rev-parse --short HEAD 2> /dev/null)

  if [ $timer_start ]; then
    command_time=$(($SECONDS - $timer_start))
    unset timer_start
  fi

  PS1="%1d"

  if [ -n "${git_branch}" ]; then
    PS1+="%F{yellow}:${git_branch}%f(${git_sha})"
  fi

  # postgres_version=$(psql -V | cut -f 3 -d ' ' | cut -f 1,2 -d .)
  # PS1+=" pg(${postgres_version})"

  if [ "${last_exit_code}" -ge 1 ]; then
    # FIXME: Make this global, maybe write to a file or something
    if [ "$NO_OOPS" != 'true' ]; then
      if [[ $(uname -s) == Linux ]]; then
        echo oops | espeak 2> /dev/null # TODO: Async here would be nice tho
      else
        # TODO: Async oops, meh this seems ok on osx
        # TODO: Allow disabling this
        say oops
      fi
    fi
    PS1="%F{red}:(%f $PS1 %F{red}${command_time}s ${last_exit_code}%f"
  else
    PS1="%F{green}:)%f $PS1 ${command_time:-0}s"
    # tput bel
  fi

  PS1="$PS1"$'\n'"$ "
}
