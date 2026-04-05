#!/bin/bash
TEMP=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -nr | head -n 1)
if [ -z "$TEMP" ]; then
    echo "N/A"
    exit 0
fi
echo "$((TEMP / 1000))°C"
