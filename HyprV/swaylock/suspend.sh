#!/bin/bash
swayidle -w \
timeout 595 ' swaylock ' \
timeout 600 ' hyprctl dispatch dpms off' \
timeout 1800 'systemctl suspend' \
resume ' hyprctl dispatch dpms on' \
before-sleep 'swaylock'
