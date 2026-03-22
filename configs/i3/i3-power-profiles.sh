#!/bin/bash

options="performance\nbalanced\npower-saver"
chosen=$(echo -e "$options" | rofi -dmenu -p "Power profile")
case "$chosen" in
  *performance) powerprofilesctl set performance ;;
  *balanced)   powerprofilesctl set balanced ;;
  *power-saver)  powerprofilesctl set balanced ;;
esac
