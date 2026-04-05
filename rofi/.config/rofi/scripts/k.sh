#!/bin/bash

CONF="$HOME/.config/hypr/keybinding.conf"

if [ -z "$1" ]; then
    # Generate the list
    grep "^bind =" "$CONF" | while read -r line; do
        # Extract comma-separated fields
        # Example: bind = $mainMod SHIFT, C, exec, $right_overlay btop
        # field 1: bind = $mainMod SHIFT
        # field 2: C
        # field 3: exec
        # field 4: $right_overlay btop
        
        # Clean up 'bind ='
        line="${line#bind = }"
        
        IFS=',' read -r f1 f2 action cmd <<< "$line"
        
        # Trim leading/trailing whitespace
        f1=$(echo "$f1" | xargs)
        f2=$(echo "$f2" | xargs)
        action=$(echo "$action" | xargs)
        cmd=$(echo "$cmd" | xargs)
        
        keys="${f1} + ${f2}"
        
        # Replace variables
        keys="${keys//\$mainMod/SUPER}"
        cmd="${cmd//\$terminal/ghostty}"
        cmd="${cmd//\$fileManager/nautilus}"
        cmd="${cmd//\$menu/rofi -show combi}"
        cmd="${cmd//\$browser/brave}"
        cmd="${cmd//\$right_overlay/term-overlay-right}"
        cmd="${cmd//\$screenshot/flameshot}"
        cmd="${cmd//\$bt/bluetui}"
        
        # Format the display
        # We use zero-width spaces or a delimiter to easily parse it later
        printf "  %-25s 󰜎 %-15s %s\n" "$keys" "$action" "$cmd"
    done
else
    # Execute the command
    # String looks like:   SUPER + C            󰜎 exec            term-overlay-right btop
    # Or:   SUPER + 1            󰜎 workspace       1
    
    ACTION=$(echo "$1" | awk -F'󰜎' '{print $2}' | awk '{print $1}')
    CMD=$(echo "$1" | awk -F'󰜎' '{print $2}' | awk '{$1=""; print $0}' | sed 's/^[ \t]*//')
    
    case "$ACTION" in
        exec)
            hyprctl dispatch exec "$CMD"
            ;;
        killactive)
            hyprctl dispatch killactive ""
            ;;
        togglefloating)
            hyprctl dispatch togglefloating ""
            ;;
        workspace)
            hyprctl dispatch workspace "$CMD"
            ;;
        movetoworkspace)
            hyprctl dispatch movetoworkspace "$CMD"
            ;;
        pseudo)
            hyprctl dispatch pseudo ""
            ;;
        layoutmsg)
            hyprctl dispatch layoutmsg "$CMD"
            ;;
        movefocus)
            hyprctl dispatch movefocus "$CMD"
            ;;
        togglespecialworkspace)
            hyprctl dispatch togglespecialworkspace "$CMD"
            ;;
    esac
fi
