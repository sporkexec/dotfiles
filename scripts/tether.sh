#!/bin/sh
if ! pgrep dbus; then
	echo Starting DBus
	sudo /usr/bin/dbus-daemon --system
fi
if ! pgrep wicd; then
	echo Starting wicd-daemon
	sudo /usr/sbin/wicd
fi

echo Creating ad-hoc interface
wicd-cli -y -A -E "beeezy" -I "169.254.0.1" -C 3

# Why wicd doesn't add a route I do not know.
echo Fixing network route
sudo route add -net 169.254.0.0 netmask 255.255.255.0 dev wlan0

echo Attempting login, are wifi and sshd on?
while ! ssh iphone; do false; done


