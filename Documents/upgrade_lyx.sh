#!/bin/zsh

local=$(pwd)
cd ~/HDD/git/lyx/

if {[ "$(git pull origin master | grep -c "Already up to date")" -ge 1 ]} &> /dev/null; then
	echo "No Updates Available!"
	cd $local
	return
else 
	echo "Do you wish to update LyX?"
	select yn in "Yes" "No"
	case $yn in
		Yes ) ./autogen.sh && ./configure && make -j4 && sudo make -j4 install && cd $local && printf "\n\n\nUPDATED\n" && return;;
    		No ) cd $local && echo "Update canceled. Please run uglyx to update!" && return;;
	esac
fi
return
