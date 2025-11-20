#!/usr/bin/env bash
# One monitor layout
sed -i 's/monitor = $secondary_monitor, 3.*/monitor = $secondary_monitor, disable/g' $HOME/.config/hypr/conf/00-monitors.conf
