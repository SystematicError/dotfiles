#!/bin/sh

# Run a daemon in the background if it already isn't running
run() {
    pgrep $1 > /dev/null || $@ &
}

run picom --experimental-backends
run pipewire
run gnome-polkit

# TODO: Change this in proper config file

xinput set-prop "DELL077D:00 06CB:7E92 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DELL077D:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "DELL077D:00 06CB:7E92 Touchpad" "libinput Disable While Typing Enabled" 0

setxkbmap -option "caps:swapescape"

