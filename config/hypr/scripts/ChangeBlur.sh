#!/bin/bash
notif="$HOME/.config/swaync/images"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" != "0" ]; then
	hyprctl eval 'hl.config({ decoration = { blur = { size = 0, passes = 0 } } })'
	notify-send -e -u low -i "$notif/note.png" " Blur off"
else
	hyprctl eval 'hl.config({ decoration = { blur = { size = 2, passes = 3 } } })'
	notify-send -e -u low -i "$notif/ja.png" " Blur on"
fi
