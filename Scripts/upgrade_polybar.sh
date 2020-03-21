#!/bin/zsh

local=$(pwd)
cd ~/HDD/git/polybar/

if {[ "$(git pull origin master | grep -c "Already up to date")" -ge 1 ]} &> /dev/null; then
	echo "No Updates Available!"
	cd $local
	return
else 
	echo "Do you wish to update Polybar?"
	select yn in "Yes" "No"
		case $yn in
			Yes ) cp ../net_nl.cpp ./src/adapters/net_nl.cpp && ./build.sh && cd $local && printf "\n\n\nUPDATED\n" && return;;
			No ) cd $local && echo "Update canceled. Please upgrade manually to update!" && return;;
		esac
fi
return
