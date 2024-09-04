#!/bin/bash
swayidle -w \
timeout 995 ' swaylock ' \
timeout 1000 ' hyprctl dispatch dpms off' \
timeout 3600 'systemctl suspend' \
resume ' hyprctl dispatch dpms on' \
before-sleep 'swaylock'
