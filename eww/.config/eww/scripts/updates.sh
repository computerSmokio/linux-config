#!/bin/bash

LAST_UPDATE=$(stat -c %y /var/lib/pacman/local 2>/dev/null | cut -d' ' -f1)

if command -v checkupdates &> /dev/null; then
    UPDATES=$(checkupdates 2>/dev/null | wc -l)
else
    UPDATES=$(pacman -Qu 2>/dev/null | wc -l)
fi

if [ -z "$UPDATES" ]; then
    UPDATES=0
fi

echo "${UPDATES} pending (Last: ${LAST_UPDATE})"
