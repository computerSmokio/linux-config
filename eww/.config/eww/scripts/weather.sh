#!/usr/bin/env bash

CACHE_FILE="$HOME/.cache/eww_weather_loc.json"

# Check if cache exists, if not, update it
if [ ! -f "$CACHE_FILE" ]; then
    $(dirname "$0")/update_location.sh
fi

# Read lat/lon
lat=$(jq -r '.lat' "$CACHE_FILE")
lon=$(jq -r '.lon' "$CACHE_FILE")

if [ -z "$lat" ] || [ -z "$lon" ] || [ "$lat" == "null" ]; then
    echo "{}"
    exit 1
fi

API_URL="https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m,relative_humidity_2m,precipitation,weather_code,wind_speed_10m&hourly=temperature_2m,precipitation_probability,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto"

# Fetch data
weather_data=$(curl -s "$API_URL")

if [ -z "$weather_data" ]; then
    echo "{}"
    exit 1
fi

# We can parse the whole thing in jq
jq -n --argjson data "$weather_data" '
def get_icon(code):
  if code == 0 then "󰖙"
  elif code == 1 then "󰖕"
  elif code == 2 then "󰖕"
  elif code == 3 then "󰖐"
  elif code == 45 or code == 48 then "󰖑"
  elif code >= 51 and code <= 67 then "󰖗"
  elif code >= 71 and code <= 77 then "󰖘"
  elif code >= 80 and code <= 82 then "󰖗"
  elif code >= 85 and code <= 86 then "󰖘"
  elif code >= 95 and code <= 99 then "󰖓"
  else "󰖂" end;

{
  current: {
    temp: ($data.current.temperature_2m | round),
    icon: get_icon($data.current.weather_code),
    rain: ($data.current.precipitation),
    wind: ($data.current.wind_speed_10m | round),
    humidity: ($data.current.relative_humidity_2m)
  },
  today: {
    day: ($data.hourly.temperature_2m[9] | round),
    noon: ($data.hourly.temperature_2m[13] | round),
    night: ($data.hourly.temperature_2m[21] | round)
  },
  forecast: [
    {
      day: "Tom",
      temp_max: ($data.daily.temperature_2m_max[1] | round),
      temp_min: ($data.daily.temperature_2m_min[1] | round),
      icon: get_icon($data.daily.weather_code[1])
    },
    {
      day: "D2",
      temp_max: ($data.daily.temperature_2m_max[2] | round),
      temp_min: ($data.daily.temperature_2m_min[2] | round),
      icon: get_icon($data.daily.weather_code[2])
    },
    {
      day: "D3",
      temp_max: ($data.daily.temperature_2m_max[3] | round),
      temp_min: ($data.daily.temperature_2m_min[3] | round),
      icon: get_icon($data.daily.weather_code[3])
    }
  ]
}'
