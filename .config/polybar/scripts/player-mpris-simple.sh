#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
	echo "$(playerctl metadata --format '#{{xesam:trackNumber}}') $(playerctl metadata title | awk -v len=20 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }') - $(playerctl metadata --format '{{ duration(position) }}|{{ duration(mpris:length) }}') "
elif [ "$player_status" = "Paused" ]; then
    echo "---Paused---"
else
    echo ""
fi

