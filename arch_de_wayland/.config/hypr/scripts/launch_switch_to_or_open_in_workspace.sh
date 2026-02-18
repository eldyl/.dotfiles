#!/usr/bin/env bash
# Application launcer is used with keybinds to launch specific applications in 
# a specific workspace if not open or switch to the application that is in its 
# workspace if the application is running

workspace="$1"
app="$2"
client_name="$3"

hyprctl dispatch workspace "$workspace"
clients=$(hyprctl clients)

if [ -n "$client_name" ]; then
    echo "$clients" | grep -qi "$app" || echo "$clients" | grep -qi "$client_name" || hyprctl dispatch exec "[workspace $workspace] uwsm-app -- $app"
else
    echo "$clients" | grep -qi "$app" || hyprctl dispatch exec "[workspace $workspace] uwsm-app -- $app"
fi
