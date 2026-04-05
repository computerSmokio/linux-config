#!/bin/bash
# Extract highest temperature from all thermal zones
TEMP=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -nr | head -n 1)

if [ -z "$TEMP" ]; then
    echo "N/A"
    exit 0
fi

# Convert millidegrees to Celsius
TEMP_C=$((TEMP / 1000))
echo "${TEMP_C}°C"
