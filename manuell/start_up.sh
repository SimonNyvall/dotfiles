#!/bin/bash

# Start commands on start up for lubuntu

xset s off -dpms

mouse_input_id=$(xinput list | grep "Logitech USB Receiver" | grep -v Keyboard | awk '{print $6}' | cut -d= -f2)

xinput --set-prop "$mouse_input_id" 342 0

xinput --set-prop "$mouse_input_id" 'libinput Accel Profile Enabled' 0 1
