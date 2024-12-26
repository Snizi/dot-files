#!/bin/bash

# Path to your pictures folder
PICTURES_FOLDER="$HOME/Pictures/Wallpapers"

# Path to hyprpaper config file
HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# Kill any existing hyprpaper process
killall -9 hyprpaper

# Wait a moment to ensure hyprpaper is terminated
sleep 1

# Select a random wallpaper from the pictures folder
RANDOM_WALLPAPER=$(find "$PICTURES_FOLDER" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# Update hyprpaper config file if a wallpaper is found
if [ -n "$RANDOM_WALLPAPER" ]; then
    echo "preload = $RANDOM_WALLPAPER" > "$HYPRPAPER_CONFIG"
    echo "wallpaper = DP-1,$RANDOM_WALLPAPER" >> "$HYPRPAPER_CONFIG"
    echo "wallpaper = DP-2,$RANDOM_WALLPAPER" >> "$HYPRPAPER_CONFIG"
    echo "wallpaper = DP-3,$RANDOM_WALLPAPER" >> "$HYPRPAPER_CONFIG"

    # Start hyprpaper with the updated config
    hyprpaper &
    killall -9 waybar
    waybar &
    wal -i "$RANDOM_WALLPAPER"
    echo "Wallpaper set to $RANDOM_WALLPAPER and config updated."
else
    echo "No wallpapers found in $PICTURES_FOLDER"
fi
