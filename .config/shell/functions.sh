function tmux_project() (
  set -e
  if [[ -z "$1" ]] ; then
    echo 'Missing argument (project name)'
    exit 1
  fi
  local project url
  project=$1

  if [[ "$1" = git@* ]]; then
    url="$1"
    project=$(echo $url | sed -E 's/.*\/(.*)\.git$/\1/g')
  else
    project="$1"
  fi

  if [ -n "$url" ] && [ ! -d "$HOME/code/$project" ]; then
    cd ~/code && git clone "$url"
  fi

  if ! tmux has-session -t $project 2>/dev/null; then
    tmux new-session -d -s $project -c ~/code/$project
  fi
  tmux switch -t $project 2>/dev/null
  # Maybe creating 2 panes and starting vim in top?
)

function run-tests() (
  set -euo pipefail

  local current_directory current_pg

  current_directory="${PWD##*/}"
  current_pg="$(current_postgres)"

  if [ -n "${PGVERSION:-}" ] && [ "$current_pg" != "$PGVERSION" ]; then
    echo "The current postgres versions $current_pg doesn't match the configured version $PGVERSION"
    exit 1
  fi

  if [ -z "${TEST_COMMAND:-}" ]; then
    if [ -f Gemfile ]; then
      bundle exec rspec "$@"
    else
      rspec "$@"
    fi
  else
    eval "$TEST_COMMAND" "$@"
  fi
)

alias t='run-tests'

# Define env vars like `SOME_NAME_DB_URL='postgres://....'`
# You then get a prompt like `SOME_NAME@localhost > _`
function db() (
  local url_var prompt url
  if [ -z "$1" ]; then
    echo "Error: Database url is empty"
    exit 1
  fi

  env_match=$(env | grep _DB_URL | grep "$1")

  if [ -z "$env_match" ]; then
    echo "Error: Could not find env var named *_DB_URL, with value '$1'"
    exit 1
  fi

  url_var=$(echo "$env_match" | cut -d '=' -f 1)

  if [ "${url_var: -7}" != "_DB_URL" ]; then
    echo "Error: The env var '${url_var}' must end in _DB_URL to be used with this db function"
    exit 1
  fi

  prompt=$(echo $url_var | cut -d '=' -f 1 | sed 's/_DB_URL//g')
  url=$(print -rl -- ${(P)url_var})
  psql -v "prompt=$prompt" "$url"
)

# TODO: This should search not only open sessions, but any project in ~/code
# It would then be more useful even though it's slow, and selecting a project without a session
# would create a new session for that project
fs() {
  local -r fmt='#{session_id}:|#S|(#{session_attached} attached)'
    { tmux display-message -p -F "$fmt" && tmux list-sessions -F "$fmt"; } \
      | awk '!seen[$1]++' \
      | column -t -s'|' \
      | fzf -q '$' --reverse --prompt 'switch session: ' -1 \
      | cut -d':' -f1 \
      | xargs tmux switch-client -t
}

if [ -z "$(ls ~/.tmux/plugins 2>/dev/null)" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# TODO:
#   - Don't hardcode switching between only 9.4 / 9.6 / 11
#   - Automatically determine currently install normal postgres version instead of hardcoding
function switch_postgres() (
  set -euo pipefail

  local to current

  to="$1"
  current=$(current_postgres)

  if [ "$to" = "$current" ]; then
    echo "Current postgres version is already $to"
    exit 1
  else
    echo "Switching postgres from $current to $to..."
    case "$to" in
      9.4)
        stop_postgres "$current"
        brew link postgresql@9.4 --force
        brew services start postgresql@9.4
        ;;
      9.6)
        stop_postgres "$current"
        brew link postgresql@9.6 --force
        brew services start postgresql@9.6
        ;;
      11.*)
        stop_postgres "$current"
        brew link postgres
        brew services start postgres
        ;;
      *)
        echo "I don't know how to switch to postgres $to :("
        exit 1
    esac
  fi
)

function current_postgres() {
  local current
  current=$(psql -V | cut -f 3 -d ' ' | cut -f 1,2 -d .)
  echo $current
}

function stop_postgres() {
  local version
  version="$1"

  case "$version" in
    9.4)
      brew services stop postgresql@9.4 2>/dev/null || echo "postgresql@9.4 not running"
      brew unlink postgresql@9.4
      ;;
    9.6)
      brew services stop postgresql@9.6 2>/dev/null || echo "postgresql@9.6 not running"
      brew unlink postgresql@9.6
      ;;
    11.*)
      brew services stop postgresql 2>/dev/null || echo "postgresql not running"
      brew unlink postgresql
      ;;
    *)
      echo "I don't know how to stop postgres $version :("
      exit 1
  esac
}
