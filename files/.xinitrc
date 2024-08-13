#!/bin/sh

xrdb -merge ~/.Xresources

# Refresh rate of the keyboard
xset r rate 150 75

mouse_id=$(xinput list --id-only "Logitech USB Receiver")
xinput set-prop $mouse_id 'libinput Natural Scrolling Enabled' 1
xinput set-prop $mouse_id 'libinput Accel Profile Enabled' 0, 1
xinput set-prop $mouse_id 'libinput Accel Speed' 0.0

# oid --latency 1 & disown

tati & disown

#xbindkeys & disown

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar.log
#polybar 2>&1 | tee -a /tmp/polybar.log & disown

# Launch picom (compton) if you want
#picom & disown

export _JAVA_AWT_WM_NONREPARENTING=1

exec dbus-launch --exit-with-session dwm
# exec dbus-launch --exit-with-session leftwm
#exec dwm
#
# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
# exec gnome-session
