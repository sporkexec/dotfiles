#!/bin/sh

# Use compose to combine keystrokes into more complex glyphs.
# The defaults: /usr/share/X11/locale/en_US.UTF-8/Compose
# Other available options: /usr/share/X11/xkb/rules/base.lst
setxkbmap -option compose:menu

# Remap caps lock to control.
setxkbmap -option ctrl:nocaps

# sscrotwm doesn't define a default pointer.
xsetroot -cursor_name left_ptr

# Prevent power-saving mode when monitors are idle.
# I always power off monitors and shut laptop lids, this is only ever annoying.
xset dpms 0 0 0
xset -dpms
xset s off

numlockx

# Tap on the trackpoint to click
#echo 1 | sudo tee /sys/devices/platform/i8042/serio1/serio2/press_to_select > /dev/null

# It's pretty obvious the machine's running, thanks.
#echo 0 | sudo tee /sys/bus/platform/devices/thinkpad_acpi/leds/tpacpi::power/brightness > /dev/null

xrdb ~/.Xresources
xrdb -merge ~/.Xresources_colors

~/bin/dpms_http.py &
exec sscrotwm

#sxhkd &
#exec bspwm
