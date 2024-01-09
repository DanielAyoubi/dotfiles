#!/bin/bash

# Command to get the monitor information
monitor_info=$(hyprctl monitors)

# Extract the height resolution for 'Monitor DP-x'
dp_monitor_height=$(echo "$monitor_info" | grep -A1 "Monitor DP-[0-9]" | grep -oP '\d+x\K\d+(?=@)')

# Extract the DP monitor identifier and its resolution
dp_monitor_info=$(echo "$monitor_info" | grep -oP 'Monitor DP-\d' | head -1)
dp_monitor_identifier=$(echo "$dp_monitor_info" | grep -oP 'DP-\d')
dp_monitor_resolution=$(echo "$monitor_info" | grep -A1 "$dp_monitor_info" | grep -oP '\d+x\d+(?=@)')

# Configuration file path
conf_file="$HOME/.config/hypr/hyprland.conf"

# Check if the necessary information and the config file exist
if [[ -z "$dp_monitor_height" || -z "$dp_monitor_identifier" || -z "$dp_monitor_resolution" || ! -f "$conf_file" ]]; then
    echo "Error: Could not find the necessary resolution(s) or the configuration file."
    exit 1
fi

# Backup the configuration file
cp "$conf_file" "$conf_file.bak"

# Update the configuration file for eDP-1
sed -i "s/\(monitor=eDP-1,[0-9]*x[0-9]*@60,\)0x[0-9]*\(,1\.00\)/\10x${dp_monitor_height}\2/" "$conf_file"

# Update the configuration file for the DP monitor
sed -i "s/monitor=${dp_monitor_identifier},[^,]*/monitor=${dp_monitor_identifier},${dp_monitor_resolution}@60/" "$conf_file"

echo "Configuration for eDP-1 and ${dp_monitor_identifier} updated."

