#!/bin/bash

function quit() {
  echo -e "$@"
  exit 1
}

if (echo "$1" | grep -Eq "([01][0-9]|2[0-3]):[0-5][0-9]") ; then
  while true ; do
    now=`date "+%H:%M"`
    if [ "x$now" == "x$1" ] ; then
      say -v Moira "it's time to go now !"
      break
    else
      echo "$now don't match $1"
      sleep 1000
    fi
  done
else
  quit "bad time pattern, please give me a time with following format : 'HH:MM'"
fi
