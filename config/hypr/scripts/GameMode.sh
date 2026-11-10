#!/bin/bash
notif="$HOME/.config/swaync/images/ja.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

HYPRGAMEMODE=$(hyprctl -j getoption animations:enabled | jq -r ".bool")
if [ "$HYPRGAMEMODE" = "true" ] ; then
    hyprctl eval 'hl.config({
        animations = { enabled = false },
        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
            active_opacity = 1,
            inactive_opacity = 1,
            fullscreen_opacity = 1,
        },
        general = { gaps_in = 0, gaps_out = 0, border_size = 1 },
    })'

    awww kill
    notify-send -e -u low -i "$notif" " Gamemode:" " enabled"
    exit
else
	awww-daemon --format xrgb && awww img "$HOME/.config/rofi/.current_wallpaper" &
	sleep 0.1
	${SCRIPTSDIR}/WallustSwww.sh
    notify-send -e -u normal -i "$notif" " Gamemode:" " disabled"
fi
hyprctl eval 'hl.config({
    animations = { enabled = true },
    decoration = {
        shadow = { enabled = true },
        blur = { enabled = true },
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1,
    },
    general = { gaps_in = 2, gaps_out = 4, border_size = 2 },
})'
