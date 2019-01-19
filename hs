#!/bin/bash

code=""

# Resolve ambiguous names
while read -r l; do
  if [ "$l" == "_" ]; then
    code=$(echo $code _)
  elif echo $l | grep --quiet '^[0-9]*$'; then
    code=$(echo $code $l)
  elif [ ! -z "$l" ]; then
    func=$(cat imp | fzf -f "$l" | head -n1)
    if [ -z "$func" ]; then
      code=$(echo $code $l)
    else
      code=$(echo $code $func)
    fi
  fi
done < <(echo "$@" | sed -E -e 's/(_|"[^"]*"|'"'[^']*'"'|[^a-zA-Z0-9_"'"'"']+|[a-zA-Z]+)/\1\n/g' | sed 's/^ \+//')


# Hole fitting
head -c -1 -q prefix <(echo "$code") > /tmp/main.hs
err=$(ghc /tmp/main.hs -o /dev/null 2>&1 >/dev/null | grep -v 'toString\|(!)\|DotDotDot\|IsFun\|defined at')
hole=$(echo "$err" | pcregrep -Mo 'Valid hole fits include.*\n *\K[^ ]+')

while read -r l; do
  code=$(echo "$code" | sed "s/_/$l/")
done < <(echo "$hole")


# echo "$err"
# echo "$code"


# Execute final code
head -c -1 -q prefix <(echo "$code") > /tmp/main.hs
cat - | runhaskell /tmp/main.hs
