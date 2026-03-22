#!/bin/bash

current=$(powerprofilesctl get)

make_label() {
  local profile="$1"
  if [ "$profile" = "$current" ]; then
    echo "* $profile"
  else
    echo "  $profile"
  fi
}

options="$(make_label performance)\n$(make_label balanced)\n$(make_label power-saver)"

chosen=$(echo -e "$options" | rofi -dmenu -p "Power profile")

case "$chosen" in
  *performance*) powerprofilesctl set performance ;;
  *balanced*)    powerprofilesctl set balanced ;;
  *power-saver*) powerprofilesctl set power-saver ;;
esac
