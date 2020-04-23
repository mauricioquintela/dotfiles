#!/bin/zsh
input_mon=$(xrandr | grep eDP | awk '{print $1}')
if [ "$input_mon" = "eDP1" ]; then
	xrandr --output HDMI1 --auto --output eDP1 --auto --primary --left-of HDMI1 --output DP1 --off 
	~/.config/polybar/launch.sh
	~/.fehbg
	return
else
	xrandr --output HDMI-1-1 --auto --output eDP-1-1 --auto --primary --left-of HDMI-1-1 --output DP-1-1 --off 
	~/.config/polybar/launch.sh
	~/.fehbg
	return
fi
