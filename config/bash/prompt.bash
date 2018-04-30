prompt_command() {
  local last_exit_code=$?

  # Save and reload the history
  history -a; history -c; history -r

  # NOTE: Colors need to be escaped with \[ & \] to allow bash to
  # calculate the length of the prompt correctly, and so wrap lines
  # correctly
  local red='\[\033[1;31m\]'
  local green='\[\033[1;32m\]'
  local yellow='\[\033[1;33m\]'
  local reset='\[\033[0m\]'

  local git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')

  if [[ ! -z $(git status -s 2> /dev/null) ]]; then
    git_branch="${yellow}${git_branch}${reset}"
  fi

  PS1="\w${git_branch}"

  if [ "${last_exit_code}" -ge 1 ]; then
    if [[ $(uname -s) == Linux ]]; then
      echo oops | espeak 2> /dev/null
    else
      say oops
    fi
    PS1+=" ${red}:(${reset} "
  else
    PS1+=" ${green}:)${reset} "
  fi
}

export PROMPT_COMMAND=prompt_command