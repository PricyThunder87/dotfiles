#!/usr/bin/env bash

power_menu() {
  printf "   Lock\n󰤄   Sleep\n󰜉   Restart\n󰐥   Shutdown\n󰍃   Logout"
}

confirm() {
  printf "Yes\nNo" | wofi --dmenu \
    --prompt "$1" \
    --width 160 \
    --lines 2 \
    --no-search \
    --location center \
    --conf ~/.config/wofi/power/config \
    --style ~/.config/wofi/power/style.css
}

choice=$(power_menu | wofi --dmenu \
  --width 220 \
  --lines 5 \
  --no-search \
  --location top_right \
  --yoffset 30 \
  --conf ~/.config/wofi/power/config \
  --style ~/.config/wofi/power/style.css
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
      swaymsg exit 2>/dev/null || hyprctl dispatch exit
    fi
    ;;
esac
