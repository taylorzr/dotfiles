# aws
alias asl='aws sso login'
function asv() {
  if [ $(ast) = "null" ]; then
    echo 'error: aws sso session expired'
    return 1
  fi
  # echo "aws sso session valid"
}
alias ast="cat ~/.aws/sso/cache/* | jq -rs 'map(select(.accessToken and .expiresAt > (now | todate)) | .accessToken)[0]'"

# kubernetes
alias k=kubectl
if command -v kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi
# alias kubectx='kubectl ctx'
function kc() {
  asv || asl
  cluster="$1"
  if [ -z "$cluster" ]; then
    cluster=$(kubectl ctx | fzf)
    if [ "$cluster" = "" ]; then
      printf "no clusters selected\n"
      return 1
    fi
  fi
  k9s --context "$cluster"
}
function kn() {
  asv || asl

  cluster="$1"
  if [ -z "$cluster" ]; then
    cluster=$(kubectl ctx | fzf)
    if [ "$cluster" = "" ]; then
      printf "no clusters selected\n"
      return 1
    fi
  fi
  selection=$(kubectl --context "$cluster" get --no-headers namespaces > /dev/null | fzf)
  if [ "$selection" = "" ]; then
    printf "no namespace selected\n"
  fi
  namespace=$(awk '{ print $1 }' <<< "$selection")
  k9s --context "$cluster" --namespace "$namespace"
}
alias kcc='echo context: $(kubectl ctx -c) namespace: $(kubectl ns -c)'
alias kar='kubectl argo rollouts'
alias argo='argocd'
