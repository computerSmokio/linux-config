#!/usr/bin/env bash

CACHE_FILE="$HOME/.cache/eww_weather_loc.json"

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$CACHE_FILE")"

# Fetch location data from ipinfo.io
location_data=$(curl -s https://ipinfo.io/json)

loc=$(echo "$location_data" | jq -r '.loc')
lat=$(echo "$loc" | cut -d',' -f1)
lon=$(echo "$loc" | cut -d',' -f2)

if [[ "$lat" != "null" && "$lon" != "null" && -n "$lat" && -n "$lon" ]]; then
    echo "{\"lat\": $lat, \"lon\": $lon}" > "$CACHE_FILE"
    echo "Location updated: $lat, $lon"
else
    echo "Failed to update location"
    exit 1
fi
