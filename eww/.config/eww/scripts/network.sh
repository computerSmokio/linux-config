#!/bin/bash
DATA=$(networkctl list --json=short 2>/dev/null)

if [ -z "$DATA" ]; then
    echo '{"icon": "󰤮", "text": "Offline"}'
    exit 0
fi

INFO=$(echo "$DATA" | jq -r '.Interfaces[] | select(.OnlineState == "online" and .Type != "loopback") | "\(.Type):\(.Name)"' | head -n 1)

if [ -z "$INFO" ]; then
    echo '{"icon": "󰤮", "text": "Offline"}'
    exit 0
fi

TYPE=$(echo "$INFO" | cut -d: -f1)
NAME=$(echo "$INFO" | cut -d: -f2)

case "$TYPE" in
    "wlan")
        echo "{\"icon\": \"󰤨\", \"text\": \"$NAME\"}"
        ;;
    "ether")
        echo "{\"icon\": \"󰈀\", \"text\": \"$NAME\"}"
        ;;
    *)
        echo "{\"icon\": \"󰈀\", \"text\": \"$NAME\"}"
        ;;
esac
