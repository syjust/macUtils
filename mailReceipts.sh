#!/bin/bash

name="`git config user.name`"
email="`git config user.email`"
read_receipt=$"{\"Disposition-Notification-To\" = \"$name <$email>\"; }"
empty_rr=$'{}'

function quit(){
  echo "ERROR: $1"
  usage
  exit 1
}
function usage(){
  echo "USAGE: $0 option"
  echo "WHERE Options ARE :"
  echo "  * --check"
  echo "  * --remove"
  echo "  * --add"
}
case $1 in
  -c|--check|check|c|'')
    res="`defaults read com.apple.mail UserHeaders`"
    echo "$res"
    echo "$res" | grep -q "JUST" \
      && echo "read receipt active" \
      || echo "read receipt inactive"
  ;;
  -r|--remove|remove|r)
    defaults write com.apple.mail UserHeaders "$empty_rr" \
      && $0 -c \
      && echo "read receipt removed successfully"
  ;;
  -a|--add|add|a)
    defaults write com.apple.mail UserHeaders "$read_receipt" \
      && $0 -c \
      && echo "read receipt added successfully"
  ;;
  *)
    quit "'$1' unvalid arg"
  ;;
esac
