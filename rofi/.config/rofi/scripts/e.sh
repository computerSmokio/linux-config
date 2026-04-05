#!/bin/bash

# Ensure we use fd if available, fallback to find
if command -v fd &> /dev/null; then
    CMD="fd --hidden --exclude .git --max-depth 4 . $HOME"
else
    CMD="find $HOME -maxdepth 4 -not -path '*/\.git/*' -not -path '*/\.cache/*'"
fi

if [ -z "$1" ]; then
    # Output all files and folders nicely formatted for rofi
    eval "$CMD" | while read -r line; do
        # Replace $HOME with ~ for cleaner UI
        clean_path="${line/#$HOME/\~}"
        
        # Add an icon based on if it's a directory or file
        if [ -d "$line" ]; then
            printf "  %s\0info\x1f%s\n" "$clean_path" "$line"
        else
            printf "  %s\0info\x1f%s\n" "$clean_path" "$line"
        fi
    done
else
    # Execution phase
    
    if [ -n "$ROFI_INFO" ]; then
        TARGET="$ROFI_INFO"
    else
        # Fallback if someone hits enter on exact raw text
        TARGET="${1#*  }" # Remove icon
        TARGET="${TARGET/\~/$HOME}"
    fi

    # Launch xplr as a right overlay targeting the selected path
    if [ -e "$TARGET" ]; then
        hyprctl dispatch exec "term-overlay-right xplr \"$TARGET\"" > /dev/null 2>&1
    fi
fi
