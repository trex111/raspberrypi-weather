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
----------------------------------------------------------------------------------
if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ]
then
  startx
fi
----------------------------------------------------------------------------------
The last bit is to setup /home/pi/.xinitrc to run chromium whenever you run startx. Here's the full list of chromium arguments.
----------------------------------------------------------------------------------
#!/usr/bin/env sh
xset -dpms
xset s off
xset s noblank

unclutter &
chromium-browser --kiosk --start-fullscreen https://yourfancywebsite.com \
  --window-size=1920,1080 \
  --window-position=0,0 \
  --incognito \
  --noerrdialogs \
  --disable-translate \
  --no-first-run \
  --fast \
  --fast-start \
  --disable-infobars \
  --disable-features=TranslateUI \
  --disk-cache-dir=/dev/null \
  --overscroll-history-navigation=0 \
  --disable-pinch
-----------------------------------------------------------------------------------
  the full scale version of the .xinitrc file is given in the files
It disables the cursor and screensaver. Then runs chromium with *all* of the flags. Set https://yourfancywebsite.com to the website which you want to display. And set --window-size to the size of your display (it's horizontal first and vertical after the comma).

You may also want to uncomment disable_overscan=1 in /boot/config.txt so that the pi boots up using the full display.

Now whenever the pi boots up it'll go into the console then on into chromium. If you want to exit you can hit Alt+F4, then enter startx to start up the browser again.
