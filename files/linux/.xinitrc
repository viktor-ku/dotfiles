#!/bin/sh

xrdb -merge ~/.Xresources

# Refresh rate of the keyboard
xset r rate 150 75

vol 40

mouse_id=$(xinput list --id-only "Kingsis Peripherals ZOWIE Gaming mouse")
xinput set-prop $mouse_id 'libinput Natural Scrolling Enabled' 1
xinput set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1
xinput set-prop $mouse_id 'libinput Accel Speed' 0.1

oid --detach --workers 1

export _JAVA_AWT_WM_NONREPARENTING=1

tati &

#xbindkeys

exec dbus-launch --exit-with-session dwm
