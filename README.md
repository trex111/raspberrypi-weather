Start with Raspbian Buster (https://downloads.raspberrypi.org/raspbian/images/raspbian-2019-06-24/).
Then install the packages required to run chromium and set the pi to boot straight into to the console.

	sudo apt-get update -qq
	sudo apt-get install update

	sudo apt-get install --no-install-recommends xserver-xorg-video-all \
	  xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils \
	  chromium-browser unclutter

# Go to: Boot Options > Console Autologin
	
	sudo raspi-config

Next edit /home/pi/.bash_profile to automatically start the gui. There's a check for the bash context first, so you don't accidentally start chromium whenever you ssh in.
	
 	if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ]
	then
  		startx
	fi

The last bit is to setup /home/pi/.xinitrc to run chromium whenever you run startx.

	sudo nano /home/pi/.xinitrc

Here's the full list of chromium arguments(https://peter.sh/experiments/chromium-command-line-switches/).

----------------------------------------------------------------------------------
	#!/usr/bin/env sh

	xset -dpms
	xset s off
	xset s noblank

	exec matchbox-window-manager -use_titlebar no &

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
-----------------------------------------------------------------------------------

The full scale version of the .xinitrc file is given in the file .xinitrc.

	sudo chmod +x /home/pi/.xinitrc

It disables the cursor and screensaver. Then runs chromium with *all* of the flags. Set https://yourfancywebsite.com to the website which you want to display.

You may also want to uncomment disable_overscan=1 in /boot/config.txt so that the pi boots up using the full display.

	sudo nano /boot/config.txt

Now whenever the pi boots up it'll go into the console then on into chromium. If you want to exit you can hit Alt+F4, then enter startx to start up the browser again.

