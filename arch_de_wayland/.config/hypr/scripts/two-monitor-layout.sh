#!/usr/bin/env bash
# Two monitor layout
sed -i 's/monitor = $secondary_monitor, disable.*/monitor = $secondary_monitor, 3840x2160@120, 0x3440, 1.66667, bitdepth, 10/g' $HOME/.config/hypr/conf/00-monitors.conf
