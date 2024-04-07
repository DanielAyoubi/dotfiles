#!/bin/bash
swayidle -w \
timeout 595 ' swaylock ' \
timeout 615 ' hyprctl dispatch dpms off' \
timeout 3600 'systemctl suspend' \
resume ' hyprctl dispatch dpms on' \
before-sleep 'swaylock'
