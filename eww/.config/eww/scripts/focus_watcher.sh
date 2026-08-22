#!/bin/bash

# Simple watcher that forcefully pauses ANY media playback in brave or chromium

while true; do
    status=$(playerctl --player=brave,chromium status 2>/dev/null)
    if [ "$status" = "Playing" ]; then
        playerctl --player=brave,chromium pause
        # notify-send -u critical "Focus Mode Active" "Media playback blocked."
    fi
    sleep 1
done
