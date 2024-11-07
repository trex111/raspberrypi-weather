#!/usr/bin/env sh
xset -dpms
xset s off
xset s noblank



exec matchbox-window-manager -use_titlebar no & ./4x4.sh &

unclutter &

chromium-browser --kiosk --start-fullscreen /home/pi/weather_forcast/weatherforcast.html
	--window-position=0,0
	--incognito \
	--noerrdialogs \
	--no-first-run \
	--fast \
	--fast-start \
	--disable-infobars \
	--display=:0 \
