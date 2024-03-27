function preexec() {
  timer_start=${timer_start:-$SECONDS}
}

function precmd() {
  local last_exit_code=$?

  if git rev-parse --git-dir &>/dev/null && git rev-parse --short HEAD &>/dev/null; then
    is_git='true'
    local git_project=$(basename $(git rev-parse --show-toplevel))
    local git_path=$(sed "s#$(git rev-parse --show-toplevel)##" <(pwd))
    local git_branch=$(git rev-parse --abbrev-ref HEAD)
    local git_sha=$(git rev-parse --short HEAD)

    # FIXME: I guess technically you could have a terraform setup not tracked by git
    if [ -d .terraform ]; then
      is_terraform='true'

      # FIXME: Doesn't change if I create/change .terraform-version file
      if [ "$last_tf_path" != "$git_path" ]; then
        # these terraform commands are pretty slow, so tracking the last tf path let's us cache
        # these variables until we cd to another directory
        export last_tf_path="$git_path"
        export tf_version=$(tfenv version-name)
        export tf_workspace=$(terraform workspace show)
      fi
    else
      is_terraform=''
    fi
  else
    is_git=''
  fi

  if [ $timer_start ]; then
    command_time=$(($SECONDS - $timer_start))
    unset timer_start
  fi

  if [ -n "$is_git" ]; then
    PS1="%F{yellow}$git_project%f$git_path" # root of project and path
    PS1+=" %F{yellow}git:${git_branch}(${git_sha})%f" # branch and sha
  else
  # PS1="%1d"
    PS1="%/"
  fi

  if [ -n "${is_terraform}" ]; then
    PS1+=" %F{blue}tf:$tf_version:$tf_workspace%f"
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
