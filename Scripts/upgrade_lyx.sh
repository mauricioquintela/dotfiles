#!/bin/zsh

local=$(pwd)
cd ~/HDD/git/lyx/
need=$(ls | grep update_needed)
if {[ "$(git pull origin master | grep -c "Already up to date")" -ge 1 ]} &> /dev/null; then
	if [ "$need" = "update_needed" ]; then
		printf "\n\n\nUpdate in queue\n\n"
		./autogen.sh
		./configure
		make -j4
		notify-send -u critical -t 50000 "UPDATE DONE! WAITING FOR PASSWORD\!"
		sudo make -j4 install
		rm update_needed
		cd $local
		printf "\n\n\nUPDATED\n"
		return
	else	
		echo "No Updates Available!"
		cd $local
		return
	fi
else 
	echo "Do you wish to update LyX?"
	select yn in "Yes" "No"
		case $yn in
			Yes) ./autogen.sh
				./configure
				make -j4
				notify-send -u critical -t 50000 "UPDATE DONE! WAITING FOR PASSWORD\!"
				sudo make -j4 install
				rm -rf update_needed
				cd $local
				printf "\n\n\nUPDATED\n"
				return;;
			No) touch update_needed
				cd $local
				echo "Update in queue! Run \"uplyx\" again to update!"
				return;;
		esac
fi
return
