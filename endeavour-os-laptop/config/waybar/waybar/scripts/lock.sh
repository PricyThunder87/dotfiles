#!/usr/bin/env bash

# Ensure environment vars are set
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}"

# Absolute path to hyprlock
/usr/bin/hyprlock || /usr/bin/loginctl lock-session
