#!/bin/bash
export PATH=$PATH:/usr/bin
bash rofi/.config/rofi/scripts/k.sh "  SUPER + E                 󰜎 exec            nautilus" &
sleep 0.5
pgrep nautilus || echo "No"
