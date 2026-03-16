#!/bin/bash
options="shutdown\nreboot\nlock\nlogout\nsuspend"
chosen=$(echo -e "$options" | rofi -dmenu -p "Power")
case "$chosen" in
  *shutdown) systemctl poweroff ;;
  *reboot)   systemctl reboot ;;
  *lock)     betterlockscreen -l blur ;;
  *logout)   i3-msg exit ;;
  *suspend)  systemctl suspend ;;
esac
