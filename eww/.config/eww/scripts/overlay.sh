#!/bin/bash
# Wrapper to spawn terminal overlays
APP_NAME=$(basename "$1" | awk '{print $1}')
exec setsid uwsm-app -- xdg-terminal-exec --app-id="org.omarchy.${APP_NAME}" -e "$@"
