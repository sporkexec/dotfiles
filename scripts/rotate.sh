#!/bin/bash
LCD=LVDS1

xrandr --output "$LCD" --rotate $1 &> /dev/null
exit 0

