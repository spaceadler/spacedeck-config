#!/bin/bash

CORNER_RADIUS=24

# Listen to playerctl for URL changes
playerctl --follow metadata mpris:artUrl | while read -r url; do
    if [[ "$url" == https* ]]; then
        curl -sL "$url" -o /tmp/feishin_raw
        
        # Write to a TEMP file first
        magick /tmp/feishin_raw -resize 120x120^ -gravity center -extent 120x120 \
               -alpha set \
               \( -size 120x120 xc:none -fill white -draw "roundrectangle 0,0 119,119 $CORNER_RADIUS,$CORNER_RADIUS" \) \
               -compose DstIn -composite \
               /tmp/feishin_cover_temp.png
               
        # Instantly replace the old file with the new one (Atomic Write)
        mv /tmp/feishin_cover_temp.png /tmp/feishin_cover.png
    fi
done
