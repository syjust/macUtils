#!/bin/bash
# @author syjust
# @see https://www.howtogeek.com/260693/how-to-disable-the-boot-sound-or-startup-chime-on-a-mac/
# How to Disable the Boot Sound (or "Startup Chime") on a Mac
# todo : disable cd at startup

usage() {
cat << EOF

Disable the Boot Sound (or "Startup Chime") on a Mac

USAGE : $0 (enable|disable) [arg]
  WHERE disable can take one arg or none for test different way to disable "startup chime"
  arg can be :
  0 = %80 (default) 
  1 = %01
  2 = %00
  3 = " " (space)

Note : root privilege is mandatory (give your password when its required)
EOF
}

quit() {
  echo -e "$1"
  usage
  exit 1
}

case $1 in
  disable)
    sudo nvram SystemAudioVolume=%80
    # Some people report that the above command doesn’t work on their Macs.
    # If it didn’t silence the startup chime on your system, you may want to
    # try running one of these other commands instead. These reportedly work
    # for some people. This may be hardware-dependent,
    # and certain commands may only work on certain hardware.
    sudo nvram SystemAudioVolume=%80
    ;;
  enable)
    sudo nvram -d SystemAudioVolume
    ;;
  --help|-h|usage)
    usage
    ;;
  *) quit "'$1' is bad arg (enable or diable is required)"
    ;;
esac
