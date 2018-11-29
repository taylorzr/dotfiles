function preexec() {
  timer_start=${timer_start:-$SECONDS}
}

function precmd() {
  local last_exit_code=$?

  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/')

  if [[ ! -z $(git status -s 2> /dev/null) ]]; then
    git_branch="%F{yellow}${git_branch}%f"
  fi

  if [ $timer_start ]; then
    command_time=$(($SECONDS - $timer_start))
    RPROMPT="${command_time}s"
    unset timer_start
  fi

  PS1="%1d"
  RPROMPT+="${git_branch}"

  if [ "${last_exit_code}" -ge 1 ]; then
    if [[ $(uname -s) == Linux ]]; then
      echo oops | espeak 2> /dev/null
    else
      # TODO: Async oops
      say oops
    fi
    PS1+=" %F{red}:(%f "
    RPROMPT=" %F{red}Exit Code: ${last_exit_code}%f $RPROMPT"
  else
    PS1+=" %F{green}:)%f "
    tput bel
  fi
}

