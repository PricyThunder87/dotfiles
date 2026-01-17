#!/usr/bin/env bash

power_menu() {
  printf "   Lock\n󰤄   Sleep\n󰜉   Restart\n󰐥   Shutdown\n󰍃   Logout"
}

confirm() {
  printf "Yes\nNo" | rofi -dmenu \
    -p "$1" \
    -no-custom \
    -lines 2
}

choice=$(power_menu | rofi -dmenu \
  -p "Power" \
  -no-custom \
  -lines 5 \
	-theme $HOME/.config/waybar/power.rasi
)

case "$choice" in
  *Lock)
    hyprlock
    ;;
  *Sleep)
    systemctl suspend
    ;;
  *Restart)
    [ "$(confirm 'Restart system?')" = "Yes" ] && systemctl reboot
    ;;
  *Shutdown)
    [ "$(confirm 'Shut down system?')" = "Yes" ] && systemctl poweroff
    ;;
  *Logout)
    if [ "$(confirm 'Log out?')" = "Yes" ]; then
      hyprctl dispatch exit
    fi
    ;;
esac
