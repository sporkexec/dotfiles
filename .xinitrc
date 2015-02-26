#!/bin/sh
# Arrange screens properly
xrandr --output HDMI2 --right-of HDMI1
xrandr --output VGA1  --right-of HDMI2

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

# Mouse acceleration for M570
xinput --set-prop 13 'Device Accel Velocity Scaling' 5
xset mouse 3 6

# Turn on numlock
numlockx

# Terminal settings
xrdb ~/.Xresources
xrdb -merge ~/.Xresources_colors

#FIXME Move to a user systemd unit, maybe?
~/bin/automation_daemon.py &

# Start WM
#exec sscrotwm
#sxhkd &
#exec ~/bin/wm
sxhkd -c ~/.config/sxhkd/sxhkdrc_kde &
exec startkde
