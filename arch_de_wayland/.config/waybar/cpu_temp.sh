#!/usr/bin/env bash

temp=$(sensors k10temp-pci-00c3 2>/dev/null | grep 'Tctl:' | awk '{print $2}' | sed 's/+//;s/°C//')
if [ -n "$temp" ]; then
    echo "$temp"
else
    echo "N/A"
fi
