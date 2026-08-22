#!/bin/bash

MODE=$1
EWW_BIN="eww" 

CURRENT_MODE=$($EWW_BIN get active_mode)

teardown() {
    case $1 in
        "gaming")
            hyprctl keyword windowrulev2 "nomaximize, class:^(steam_app_.*)$" # Resetting to default or just remove the specific rule if we can
            hyprctl reload
            ;;
        "focus")
            pkill -f focus_watcher.sh
            ;;
        "coding")
            ;;
    esac
}

setup() {
    case $1 in
        "gaming")
            hyprctl dispatch workspace 1
            hyprctl dispatch exec "[workspace 1 silent] vesktop"
            hyprctl dispatch workspace 9
            hyprctl dispatch exec "[workspace 9 silent] steam"
            
            hyprctl keyword windowrulev2 "workspace 10 silent, class:^(steam_app_.*)$"
            hyprctl keyword windowrulev2 "workspace 10 silent, class:^(gamescope)$"
            ;;
        "focus")
            ~/.config/eww/scripts/focus_watcher.sh &
            ;;
        "coding")
            ;;
    esac
}

if [ "$CURRENT_MODE" != "none" ]; then
    teardown "$CURRENT_MODE"
fi

if [ "$CURRENT_MODE" == "$MODE" ]; then
    $EWW_BIN update active_mode="none"
    exit 0
fi

$EWW_BIN update active_mode="$MODE"
setup "$MODE"
