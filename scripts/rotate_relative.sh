#!/bin/bash
LCD=LVDS
MODE=normal
OUTPUT=normal

STATE="$(xrandr --query | grep $LCD)"

echo "$STATE" | grep "left (" &> /dev/null
if [ $? -eq 0 ]; then MODE=left; fi
echo "$STATE" | grep "right (" &> /dev/null
if [ $? -eq 0 ]; then MODE=right; fi
echo "$STATE" | grep "inverted (" &> /dev/null
if [ $? -eq 0 ]; then MODE=inv; fi

case "$1" in
	right)
		case "$MODE" in
			right)
				OUTPUT=inverted
			;;
			left)
				OUTPUT=normal
			;;
			inv)
				OUTPUT=left
			;;
			normal)
				OUTPUT=right
			;;
		esac
	;;
	left)
		case "$MODE" in
			right)
				OUTPUT=normal
			;;
			left)
				OUTPUT=inverted
			;;
			inv)
				OUTPUT=right
			;;
			normal)
				OUTPUT=left
			;;
		esac
	;;
esac
echo "$MODE $OUTPUT"
xrandr --output "$LCD" --rotate $OUTPUT &> /dev/null
exit 0

