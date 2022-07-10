#!/bin/sh

echo "Updating modules..."
git submodule foreach --recursive git pull --no-rebase

echo

echo "Syncing mpv scripts..."
curl https://raw.githubusercontent.com/darsain/uosc/master/uosc.lua > mpv/scripts/uosc.lua

