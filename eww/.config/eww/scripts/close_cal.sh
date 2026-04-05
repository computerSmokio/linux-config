#!/bin/bash
sleep 0.15
HOVER=$(eww get cal_hover)
if [ "$HOVER" == "false" ]; then
    eww close calendar
fi