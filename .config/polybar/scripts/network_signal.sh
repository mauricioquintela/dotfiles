#!/bin/zsh
while true; do
	if [ "$(iwconfig wlp3s0 | grep "Signal level" | awk '{print substr( $4, 7,8)}')" ]; then
		current=$(iwconfig wlp3s0 | grep "Signal level" | awk '{print substr( $4, 7,8)}')
		value=`python -c "print(int(max(min((max(-100,min($current,-40))+100)/60*100, 100), 0)))"`
		echo " "$value" %"
	else
		echo "DC"
	fi
	sleep 60 &
	wait
done
