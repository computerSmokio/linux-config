#!/bin/bash
if ! command -v bluetoothctl &> /dev/null; then
    echo '{"icon": "󰂲", "text": "No BT"}'
    exit 0
fi

POWERED=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$POWERED" ]; then
    echo '{"icon": "󰂲", "text": "Off"}'
else
    CONNECTED=$(bluetoothctl info | grep "Name" | cut -d ' ' -f 2-)
    if [ -n "$CONNECTED" ]; then
        echo "{\"icon\": \"󰂱\", \"text\": \"$CONNECTED\"}"
    else
        echo '{"icon": "󰂯", "text": "On"}'
    fi
fi
