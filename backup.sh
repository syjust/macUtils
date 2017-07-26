#!/bin/bash

quit() {
  echo -e "$@"
  exit 1
}

dirs="$HOME/$1"
savepath="$HOME"
for d in $dirs ; do
  [ -d $d ] || quit "$d not found"
  base="`basename $d`"
  dir="`dirname $d`"
  archivename="$base-`date '+%Y%m%d%H%M%S'`.tgz"
  cd $dir
  files="`find $base \
    -type f \
    ! -name "*DS_Store" \
    ! -name "*TemporaryItems" \
    ! -name "*swp" \
  `"
  if [ ! -z "$files" ] ; then
    echo "tar -czf $archivename $files"
  fi
done
