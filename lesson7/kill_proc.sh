#!/bin/bash
#
# script to find process by pid.
if [[ "$1" =~ ^[0-9]+$ ]]; then
    PID="$1"
else
    PID="$(pidof $1)"
fi
if [[ -z "$PID" ]]; then
    printf "Unable to resolve process: '$1'!\n"
    exit 1
fi
cat /proc/$PID/cmdline | sed 's/\x0/ /' && printf "\n"