#!/bin/zsh
input_mon=$(xrandr | grep eDP | awk '{print $1}')
if [ "$input_mon" = "eDP1" ]; then
	xrandr --output DP1 --off --output HDMI1 --off --output eDP1 --primary --auto
	~/.config/polybar/launch.sh
	~/.fehbg
	return
else
	xrandr --output DP-1-1 --off --output HDMI-1-1 --off --output eDP-1-1 --primary --auto
	~/.config/polybar/launch.sh
	~/.fehbg
	return
fi
