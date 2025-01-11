# Path stuff
export GOPATH="$HOME/go"
path+=(/usr/local/go/bin) # manually installed go to get 1.22
path+=("${GOPATH}/bin")
path+=("$HOME/.rd/bin") # rancher desktop

path+=("${KREW_ROOT:-$HOME/.krew}/bin")
if [ $(uname -s) = 'Linux' ]; then
  # brew and aws cli
  path+=("$HOME/.local/bin")
else
  path+=("/opt/homebrew/opt/python/libexec/bin")
  path+=("/Users/zach.taylor/.local/bin")  # pipx binaries
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
