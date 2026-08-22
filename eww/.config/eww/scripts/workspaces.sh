#!/bin/bash

get_ws_json() {
    local ACTIVE
    ACTIVE=$(hyprctl monitors -j | jq '.[] | select(.focused == true).activeWorkspace.id')
    if [ -z "$ACTIVE" ] || [ "$ACTIVE" == "null" ]; then ACTIVE=1; fi
    
    jq -n --argjson active "$ACTIVE" -c '[
        range(-2; 3) |
        ( ($active + . - 1) % 10 ) as $idx |
        ( if $idx < 0 then $idx + 10 else $idx end ) as $norm_idx |
        ($norm_idx + 1) as $id |
        {
            id: $id,
            text: (if $id == 10 then "0" else ($id|tostring) end),
            valid: true,
            active: (. == 0)
        }
    ]'
}

get_ws_json

HYPR_DIR="/run/user/$(id -u)/hypr"
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    SIGNATURE=$(ls -1t "$HYPR_DIR" | head -n 1)
else
    SIGNATURE="$HYPRLAND_INSTANCE_SIGNATURE"
fi

SOCKET="$HYPR_DIR/$SIGNATURE/.socket2.sock"
if [ ! -S "$SOCKET" ]; then
    SOCKET="$HYPR_DIR/$SIGNATURE/.socket2.s"
fi

if [ ! -S "$SOCKET" ]; then
    while true; do get_ws_json; sleep 0.5; done
    exit 0
fi

socat -U - "UNIX-CONNECT:$SOCKET" | while read -r line; do
    case ${line%>>*} in
        workspace|focusedmon)
            get_ws_json
            ;;
    esac
done
