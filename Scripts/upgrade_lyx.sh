#!/bin/zsh

local=$(pwd)
cd ~/HDD/git/lyx/
need=$(ls | grep update_needed)
sudo_need=$(ls | grep sudo_needed)
if {[ "$(git pull origin master | grep -c "Already up to date")" -ge 1 ]}; then
	if [ "$need" = "update_needed" ]; then
		printf "\n\n\nUpdate in queue\n\n"
		printf "\n\n\nStarting update\n\n"
		./autogen.sh
		./configure
		make -j4
		notify-send -u critical -t 10000 "UPDATE DONE! WAITING FOR PASSWORD!"
		if sudo make install; then
			printf "\n\n\nUPDATED\n"
			rm -rf update_needed
			cd $local
			return
		else
			touch sudo_needed
			printf "\n\n\nPASSWORD NEEDED! RUN \"uplyx\" AGAIN"
			rm -rf update_needed
			cd $local
			return
		fi
	elif [ "$sudo_need" = "sudo_needed" ]; then
		notify-send -u critical -t 10000 "WAITING FOR PASSWORD!"
		sudo make install
		rm -rf sudo_needed
		cd $local
		printf "\n\n\nUPDATED\n"
		return
	else	
		echo "No Updates Available!"
		cd $local
		return
	fi
else 
	printf "\n\nDo you wish to update LyX?\n"
	select yn in "Yes" "No"
		case $yn in
			Yes) rm -rf update_needed
				./autogen.sh
				./configure
				make -j4
				notify-send -u critical -t 10000 "UPDATE DONE! WAITING FOR PASSWORD!"
				if sudo make install; then
					printf "\n\n\nUPDATED\n"
					cd $local
				else
					touch sudo_needed
					printf "\n\n\nPASSWORD NEEDED! RUN \"uplyx\" AGAIN"
					cd $local
				fi
				return;;
			No) touch update_needed
				cd $local
				echo "Update in queue! Run \"uplyx\" again to update!"
				return;;
		esac
fi
return
