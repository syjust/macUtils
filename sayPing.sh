#!/bin/bash
export COLUMNS=30
# speak when host comeback

speak() {
  echo "$@"
  case $dev in
    none)
      say "$@"
    ;;
    silent)
      echo "SILENT: $@"
    ;;
    *)
      id=${dev%%_*}
      #echo "id:$id"
      say -a $id "$@"
    ;;
  esac
}

function quit() {
  speak "ERROR: $@"
  exit 1
}

host=$1
device_list=`say -a ? | sed 's/ /_/g;s/^_*//g'`
echo "choose device output : "
select dev in none silent $device_list ; do
  echo "'$dev' choosen"
  break
done

if [ -z "$host" ] ; then
  quit "host not set"
else
  cnt=0
  while true ; do
    d="`date "+%Y-%m-%d %H:%M:%S"`"
    echo -n "[$d] : ping $host ($cnt) ... "
    ping -c 1 -i 1 $host > /dev/null 2>&1 \
      && echo "OK" \
      && break \
      || echo "KO"
    sleep 1
    let cnt++
  done
  speak "host $host came back"
fi

