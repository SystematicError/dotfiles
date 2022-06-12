#!/bin/sh

if [ -z "$DOTFILES_DIR" ]; then
    printf "\u001b[1m\u001b[31m"
    printf "DOTFILES_DIR environment variable was not passed!"
    printf "\u001b[0m\n"
fi

# Not technically a "build" but adding it anyway
# Update mpv uosc script
curl https://raw.githubusercontent.com/darsain/uosc/master/uosc.lua > mpv/scripts/uosc.lua

