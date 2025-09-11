#!/usr/bin/env bash

workspace=$1
app=$2

hyprctl dispatch workspace $workspace
hyprctl clients | grep -qi $app || hyprctl dispatch exec "[workspace $workspace] $app"
