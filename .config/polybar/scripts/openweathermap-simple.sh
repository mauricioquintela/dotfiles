#!/bin/zsh
get_icon() {
	case $1 in
		01d) icon="";;
		01n) icon="";;
		02d) icon="";;
		02n) icon="";;
		03*) icon="";;
		04*) icon="";;
		09d) icon="";;
		09n) icon="";;
		10d) icon="";;
		10n) icon="";;
		11d) icon="";;
		11n) icon="";;
		13d) icon="";;
		13n) icon="";;
		50d) icon="";;
		50n) icon="";;
		*) icon="";
	esac

	echo $icon
}


KEY="dadf8578fc8561a106c56c6185b22ab6"
CITY="Caminha,PT"
UNITS="metric"
SYMBOL="°C"

API="https://api.openweathermap.org/data/2.5"

while true; do
	if [ -n "$CITY" ]; then
		if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
			CITY_PARAM="id=$CITY"
		else
			CITY_PARAM="q=$CITY"
		fi

		weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
	else
		location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

		if [ -n "$location" ]; then
			location_lat="$(echo "$location" | jq '.location.lat')"
			location_lon="$(echo "$location" | jq '.location.lng')"

			weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
		fi
	fi

	if [ -n "$weather" ]; then
		weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
		weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
		rm -f ~/.config/polybar/scripts/weather.png
		curl -s wttr.in/caminha_portugal.png --output ~/.config/polybar/scripts/weather.png 2>/dev/null
		echo "$(get_icon "$weather_icon")""$weather_temp$SYMBOL"
	fi
	sleep 1800 &
	wait
done
