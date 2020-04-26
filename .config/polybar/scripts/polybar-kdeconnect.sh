#!/bin/bash

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=28
WIDTH_WIDE=24
THEME=material

# Color Settings of Icon shown in Polybar
COLOR_DISCONNECTED='#000'       # Device Disconnected
COLOR_NEWDEVICE='#ff0'          # New Device
COLOR_BATTERY_90='#fff'         # Battery >= 90
COLOR_BATTERY_80='#ccc'         # Battery >= 80
COLOR_BATTERY_70='#aaa'         # Battery >= 70
COLOR_BATTERY_60='#888'         # Battery >= 60
COLOR_BATTERY_50='#666'         # Battery >= 50
COLOR_BATTERY_LOW='#f00'        # Battery <  50

# Icons shown in Polybar
ICON_SMARTPHONE='  '
ICON_TABLET='  '
SEPERATOR='|'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

show_devices () {
	IFS=$','
	devices=""
	for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
		deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
		devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)
		devicetype=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.type)
		isreach="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isReachable)"
		istrust="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isTrusted)"
		if [ "$isreach" = "true" ] && [ "$istrust" = "true" ]
		then
			battery="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.battery.charge)"
			icon=$(get_icon "$battery" "$devicetype")
			devices+="%{A1:$DIR/polybar-kdeconnect.sh -n '$devicename' -i $deviceid -b $battery -m:}$icon%{A}$SEPERATOR"
		elif [ "$isreach" = "false" ] && [ "$istrust" = "true" ]
		then
			icon="$(get_icon -1 "$devicetype")"
			devices+="%{A1:$DIR/polybar-kdeconnect.sh -r:}$icon%{A}$SEPERATOR"
		else
			haspairing="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.hasPairingRequests)"
			if [ "$haspairing" = "true" ]
			then
				show_pmenu2 "$devicename" "$deviceid"
			fi
			icon=$(get_icon -2 "$devicetype")
			devices+="%{A1:$DIR/polybar-kdeconnect.sh -n $devicename -i $deviceid -p:}$icon%{A}$SEPERATOR"

		fi
	done
	echo "${devices::-1}"
}

show_menu () {
	optionNum=6
	options=$(echo "Battery: $DEV_BATTERY%|Ping|Find Device|Send File|Browse Files|Send SMS|Unpair")
	options+=$(printf "|Refresh")
	menu="$(echo $options | rofi -sep "|" -dmenu -i -p "$DEV_NAME" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 4 -padding 20 -lines $optionNum)"
	case "$menu" in
		*'Ping')
			message=$(echo " " | rofi sep "|" -dmenu -i -p "Message for ping")    
			kdeconnect-cli --ping-msg "$message" -d $DEV_ID ;;
		*'Find Device') 
			kdeconnect-cli --ring -d $DEV_ID ;;
		*'Send File') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/share" org.kde.kdeconnect.device.share.shareUrl "file://$(zenity --file-selection)" ;;
		*'Browse Files')
			if "$(qdbus --literal org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.isMounted)" == "false"; then
				qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.mount
				thunar "/run/user/1000/$DEV_ID"
			else
				thunar "/run/user/1000/$DEV_ID"
			fi
			qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID/sftp" org.kde.kdeconnect.device.sftp.startBrowsing;;
		*'Send SMS' )
			message=$(echo "a sair |chego daqui a 25-30 |ok" | rofi -sep "|" -dmenu -i -p "Msg to send")
			if test -f "$HOME/Scripts/.contacts.txt"; then
				recipient=$(cat ~/Scripts/.contacts.txt | rofi -sep "|" -dmenu -i -p "Recipient's phone #" | awk -F: '{print $2}')
			else
				recipient=$(echo "" | rofi -sep "|" -dmenu -i -p "Recipient's phone #" | awk -F: '{print $2}')
			fi
			kdeconnect-cli --send-sms "$message" --destination "$recipient" -d $DEV_ID ;;
		*'Refresh' )
			kdeconnect-cli --refresh;;
		#              *'Unpair' ) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID" org.kde.kdeconnect.device.unpair
		esac
	}

show_rmenu () {
	menu="$(rofi -sep "|" -dmenu -i -p "No connection" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 1 -padding 20 -lines 1 <<< "Refresh Connections")"
	case "$menu" in
		*'Refresh') 
			kdeconnect-cli --refresh;;
	esac
}

show_pmenu () {
	menu="$(rofi -sep "|" -dmenu -i -p "$DEV_NAME" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH -hide-scrollbar -line-padding 1 -padding 20 -lines 1 <<< "Pair Device")"
	case "$menu" in
		*'Pair Device') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEV_ID" org.kde.kdeconnect.device.requestPair
	esac
}

show_pmenu2 () {
	menu="$(rofi -sep "|" -dmenu -i -p "$1 has sent a pairing request" -location $LOCATION -yoffset $YOFFSET -xoffset $XOFFSET -theme $THEME -width $WIDTH_WIDE -hide-scrollbar -line-padding 4 -padding 20 -lines 2 <<< "Accept|Reject")"
	case "$menu" in
		*'Accept') qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.acceptPairing ;;
		*) qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$2" org.kde.kdeconnect.device.rejectPairing
	esac

}
get_icon () {
	if [ "$2" = "tablet" ]
	then
		icon=$ICON_TABLET
	else
		icon=$ICON_SMARTPHONE
	fi
	case $1 in
		"-1")     ICON="%{F$COLOR_DISCONNECTED}$icon%{F-}" ;;
		#    "-2")     ICON="%{F$COLOR_NEWDEVICE}$icon%{F-}" ;;
		"-2") ICON=" ";;
		5*)     ICON="%{F$COLOR_BATTERY_50}$icon%{F-}" ;;
		6*)     ICON="%{F$COLOR_BATTERY_60}$icon%{F-}" ;;
		7*)     ICON="%{F$COLOR_BATTERY_70}$icon%{F-}" ;;
		8*)     ICON="%{F$COLOR_BATTERY_80}$icon%{F-}" ;;
		9*|100) ICON="%{F$COLOR_BATTERY_90}$icon%{F-}" ;;
		*)      ICON="%{F$COLOR_BATTERY_LOW}$icon%{F-}" ;;
	esac
	echo $ICON
}

unset DEV_ID DEV_NAME DEV_BATTERY
while getopts 'di:n:b:mpr' c
do
	# shellcheck disable=SC2220
	case $c in
		d) show_devices ;;
		i) DEV_ID=$OPTARG ;;
		n) DEV_NAME=$OPTARG ;;
		b) DEV_BATTERY=$OPTARG ;;
		m) show_menu  ;;
		p) show_pmenu ;;
		r) show_rmenu ;;
	esac
done
