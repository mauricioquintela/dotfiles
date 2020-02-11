#!/bin/zsh
if [ "$(iw dev wlp3s0 station dump | grep signal: | awk '{print $2}')" ]; then
	current=$(iw dev wlp3s0 station dump | grep signal: | awk '{print $2}')
	value=`python -c "print(int(max(min((max(-90,min($current,-40))+90)/50*100, 90), 0)))"`
	echo " "$value" %"
else
	echo "DC"

fi


