#!/bin/zsh
input_mon=$(xrandr | grep eDP | awk '{print $1}')
if [ "$input_mon" = "eDP1" ]; then
	xrandr --output DP1 --mode 1440x900 --rate 75 --output eDP1 --auto --primary --right-of DP1 --output HDMI1 --off || xrandr --output DP1 --auto --output eDP1 --auto --primary --right-of DP1 --output HDMI1 --off  
	~/.config/polybar/launch.sh
	~/.fehbg
	return
else
	xrandr --output DP-1-1 --mode 1440x900 --rate 75 --output eDP-1-1 --auto --primary --right-of DP-1-1 --output HDMI-1-1 --off || xrandr --output DP-1-1 --auto --output eDP-1-1 --auto --primary --right-of DP-1-1 --output HDMI-1-1 --off  
	~/.config/polybar/launch.sh
	~/.fehbg
	return
fi
