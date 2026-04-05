#!/bin/bash
VAR=$1
STATE=$(eww get "$VAR")
if [ "$STATE" == "true" ]; then
    eww update "$VAR=false"
else
    eww update "$VAR=true"
fi
