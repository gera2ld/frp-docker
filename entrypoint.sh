#!/bin/sh

PATH=$PATH:/frp
n=1
while true; do
  "$@"
  if [ $n -gt 5 ]; then
    exit 1
  fi
  # Retry later in case volumes or deps are not ready yet
  sleep $n
  n=$((n+1))
done
