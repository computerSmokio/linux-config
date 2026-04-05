#!/bin/bash

CONF="$HOME/.config/hypr/keybinding.conf"

if [ -z "$1" ]; then
    # Generate the list
    grep -E "^bind[a-z]* =" "$CONF" | while read -r line; do
        desc=""
        if [[ "$line" =~ \#rofi:.* ]]; then
            desc="${line#*#rofi: }"
            line="${line%%#rofi:*}"
        fi
        
        line="${line#bind = }"
        line="${line#bindm = }"
        line="${line#binde = }"
        line="${line#bindl = }"
        line="${line#bindel = }"
        
        IFS=',' read -r f1 f2 action cmd <<< "$line"
        
        f1=$(echo "$f1" | xargs)
        f2=$(echo "$f2" | xargs)
        action=$(echo "$action" | xargs)
        cmd=$(echo "$cmd" | xargs)
        
        keys="${f1} + ${f2}"
        keys="${keys//\$mainMod/SUPER}"
        
        cmd="${cmd//\$terminal/ghostty}"
        cmd="${cmd//\$fileManager/nautilus}"
        cmd="${cmd//\$menu/rofi -show combi}"
        cmd="${cmd//\$browser/brave}"
        cmd="${cmd//\$right_overlay/term-overlay-right}"
        cmd="${cmd//\$screenshot/flameshot}"
        cmd="${cmd//\$bt/bluetui}"
        
        if [ -n "$desc" ]; then
            display_text="$desc"
        else
            display_text="$cmd"
        fi
        
        # Pad with 150 spaces to ensure the delimiter is pushed completely out of the Rofi window
        # The delimiter 󰜎 is used to split the command later
        padding=$(printf '%150s')
        printf "  %-25s %s%s󰜎%s󰜎%s\n" "$keys" "$display_text" "$padding" "$action" "$cmd"
    done
else
    # Execution phase
    # String looks like:   SUPER + C     Open System Monitor      [150 spaces]   󰜎exec󰜎btop
    
    ACTION=$(echo "$1" | awk -F'󰜎' '{print $(NF-1)}')
    CMD=$(echo "$1" | awk -F'󰜎' '{print $NF}')
    
    case "$ACTION" in
        exec) hyprctl dispatch exec "$CMD" > /dev/null 2>&1 ;;
        killactive) hyprctl dispatch killactive "" > /dev/null 2>&1 ;;
        togglefloating) hyprctl dispatch togglefloating "" > /dev/null 2>&1 ;;
        workspace) hyprctl dispatch workspace "$CMD" > /dev/null 2>&1 ;;
        movetoworkspace) hyprctl dispatch movetoworkspace "$CMD" > /dev/null 2>&1 ;;
        pseudo) hyprctl dispatch pseudo "" > /dev/null 2>&1 ;;
        layoutmsg) hyprctl dispatch layoutmsg "$CMD" > /dev/null 2>&1 ;;
        movefocus) hyprctl dispatch movefocus "$CMD" > /dev/null 2>&1 ;;
        togglespecialworkspace) hyprctl dispatch togglespecialworkspace "$CMD" > /dev/null 2>&1 ;;
    esac
fi
