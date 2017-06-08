#!/bin/bash
cnt=0
host=10.31.100.206
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

say -a 46 "syl dev host came back"
