#!/usr/bin/env bash

workspace=$1
app=$2
client_name=$3

hyprctl dispatch workspace "$workspace"
clients=$(hyprctl clients)

if [ -n "$client_name" ]; then
    echo "$clients" | grep -qi "$app" || echo "$clients" | grep -qi "$client_name" || hyprctl dispatch exec "[workspace $workspace] $app"
else
    echo "$clients" | grep -qi "$app" || hyprctl dispatch exec "[workspace $workspace] $app"
fi
