#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar for intel or nvidia gpu, depending on the connected screen
input_mon=$(xrandr | grep eDP | awk '{print $1}')
if [ "$input_mon" = "eDP1" ]; then
	polybar -r example-intel &
	echo "Intel GPU polybar launched..."
	return
else
	polybar -r example-nvidia &
	echo "Nvidia GPU polybar launched..."
	return
fi

