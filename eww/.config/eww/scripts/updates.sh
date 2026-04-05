#!/bin/bash

# Get the last time pacman DB was modified (last install/update)
LAST_UPDATE=$(stat -c %y /var/lib/pacman/local 2>/dev/null | cut -d' ' -f1)

# Get the number of pending updates
# checkupdates is part of pacman-contrib and doesn't require root
if command -v checkupdates &> /dev/null; then
    UPDATES=$(checkupdates 2>/dev/null | wc -l)
else
    # Fallback, though pacman -Qu might need sync first
    UPDATES=$(pacman -Qu 2>/dev/null | wc -l)
fi

if [ -z "$UPDATES" ]; then
    UPDATES=0
fi

echo "${UPDATES} pending (Last: ${LAST_UPDATE})"
