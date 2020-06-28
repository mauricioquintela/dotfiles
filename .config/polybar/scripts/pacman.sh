#!/bin/zsh
while true; do
	if ! updates_arch=$(systemd-run --scope --user -p MemoryLimit=100M checkupdates 2> /dev/null | wc -l ); then
		updates_arch=0
	fi

	if ! updates_aur=$(systemd-run --scope --user -p MemoryLimit=100M yay -Qum  2> /dev/null | wc -l); then
		# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
		# if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
		# if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
		# if ! updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l); then
		updates_aur=0
	fi

	updates=$(($updates_arch + $updates_aur))

	if [ "$updates" -gt 0 ]; then
		echo "# $updates_arch + $updates_aur"
	else
		echo ""
	fi
	sleep 3600 &
	wait
done
