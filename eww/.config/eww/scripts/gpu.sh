#!/bin/bash
if ! command -v nvidia-smi &> /dev/null; then
    echo "N/A"
    exit 0
fi
TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null)
USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
echo "${USAGE}% ${TEMP}°C"
