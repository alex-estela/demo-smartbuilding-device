#! /bin/sh

# tested with raspbian ISO 2016-09-23-raspbian-jessie.img
# assumes this action was already performed before running this install.sh script:
# cd /home/pi && git clone https://github.com/actility/demo-smartbuilding-device

echo '* Demo SmartBuilding Device installer *'
echo 'Type "raspberry" when asked for root password (default).'

sudo apt-get update

# sudo apt-get upgrade -y
# sudo apt-get dist-upgrade �y

setxkbmap fr

sudo apt-get install -y node

sudo sed -i '/README/alcd_rotate=2' /boot/config.txt

sudo sed -i '/[SeatDefaults]/axserver-command=X -nocursor -s 0 dpms' /etc/lightdm/lightdm.conf

echo '#!/bin/bash
cd /home/pi/demo-smartbuilding-device
node server.js' >> /home/pi/launcher

mv /home/pi/.config/lxsession/LXDE-pi/autostart /home/pi/.config/lxsession/LXDE-pi/autostart.bak
echo '@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@point-rpi
@lxterminal -e "/home/pi/launcher.sh"
@chromium-browser --start-fullscreen http://localhost:8080 ' >> /home/pi/.config/lxsession/LXDE-pi/autostart

cd /home/pi/demo-smartbuilding-device && npm install

sudo reboot