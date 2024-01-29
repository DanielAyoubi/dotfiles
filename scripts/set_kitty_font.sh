#!/bin/bash

# Check if any DP monitor (like DP-1, DP-2, etc.) is active
if hyprctl monitors | grep -qE "Monitor DP-[0-9]+"; then
    # If any DP monitor is active, set Kitty font size to 14
    kitty @ set-font-size 10
else
    # Set a default font size for other cases if needed
    kitty @ set-font-size 13.5
fi

