#!/bin/bash

# Ensure we use fd if available, fallback to find
if command -v fd &> /dev/null; then
    CMD="fd --hidden --exclude .git --max-depth 4 . $HOME"
else
    CMD="find $HOME -maxdepth 4 -not -path '*/\.git/*' -not -path '*/\.cache/*'"
fi

if [ -z "$1" ]; then
    eval "$CMD" | while read -r line; do
        clean_path="${line/#$HOME/\~}"
        
        if [ -d "$line" ]; then
            printf "  %s\0info\x1f%s\n" "$clean_path" "$line"
        else
            printf "  %s\0info\x1f%s\n" "$clean_path" "$line"
        fi
    done
else
    if [ -n "$ROFI_INFO" ]; then
        TARGET="$ROFI_INFO"
    else
        TARGET="${1#*  }"
        TARGET="${TARGET/\~/$HOME}"
    fi

    if [ -e "$TARGET" ]; then
        hyprctl dispatch exec "term-overlay-right nvim \"$TARGET\"" > /dev/null 2>&1
    fi
fi
