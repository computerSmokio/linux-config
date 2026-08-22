#!/bin/bash
if ! command -v wpctl &> /dev/null; then
    echo '{"icon": "󰕿", "text": "0%"}'
    exit 0
fi

VOL_DATA=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
VOL=$(echo "$VOL_DATA" | awk '{print $2}')
MUTE=$(echo "$VOL_DATA" | awk '{print $3}')

if [ "$MUTE" == "[MUTED]" ]; then
    echo '{"icon": "󰝟", "text": "Muted"}'
    exit 0
fi

if [ -z "$VOL" ]; then
    echo '{"icon": "󰕿", "text": "0%"}'
    exit 0
fi

VOL_PCT=$(echo "$VOL * 100" | bc | cut -d. -f1)

if [ "$VOL_PCT" -eq 0 ]; then
    echo "{\"icon\": \"󰕿\", \"text\": \"${VOL_PCT}%\"}"
elif [ "$VOL_PCT" -lt 50 ]; then
    echo "{\"icon\": \"󰖀\", \"text\": \"${VOL_PCT}%\"}"
else
    echo "{\"icon\": \"󰕾\", \"text\": \"${VOL_PCT}%\"}"
fi
