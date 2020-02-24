#!/usr/bin/env bash

set -euo pipefail

function charge() {
  local day="$1"
  local amount="$2"

  echo "${day} +${amount}" >> transactions
}

function pay() {
  local day="$1"
  local amount="$2"

  echo "${day} -${amount}" >> transactions
}

function balance() {
  local period_end="$1"
  local total_interest="0"
  local running_balance="0"

  exec 3< transactions
  read -r <&3 # Skip first line so we can use fd 3 for getting next transaction day

  local day amount next_day calculation interest
  while read -r transaction; do
    read -r next_transaction <&3 || next_transaction="$period_end +0"

    day="$(echo "$transaction" | cut -d ' ' -f 1)"
    amount="$(echo "$transaction" | cut -d ' ' -f 2)"
    next_day="$(echo "$next_transaction" | cut -d ' ' -f 1)"

    running_balance="$(("$running_balance" + "$amount"))"

    calculation="$running_balance * 0.35 / 365 * ($next_day - $day)"
    echo "$calculation" >&2

    interest="$(echo "$calculation" | bc -l)"
    total_interest="$(echo "$total_interest + $interest" | bc -l)"
  done < transactions

  balance="$(echo "$running_balance + $total_interest" | bc -l)"

  printf "%.2f\n" "$balance"
}

case "$1" in
  charge)
    charge "$2" "$3"
    ;;
  pay)
    pay "$2" "$3"
    ;;
  balance)
    balance "$2"
    ;;
  reset)
    : > transactions
    ;;
  *)
    echo "Invalid Command"
    exit 1
esac

# E.g.
# $ ./cc.sh reset
# $ ./cc.sh charge 0 500
# $ ./cc.sh pay 15 200
# $ ./cc.sh charge 25 100
# $ ./cc.sh balance 30
# 500 * 0.35 / 365 * (15 - 0)
# 300 * 0.35 / 365 * (25 - 15)
# 400 * 0.35 / 365 * (30 - 25)
# 411.99
#
# TODO:
# - Use flags instead of args so you don't confuse day/amount
# - Open a card with a name and an apr/limit instead of using hardcoded transactions file
#   First line could be data, next lines could be transactions
# - Tests
# - Order transactions before calc balance
