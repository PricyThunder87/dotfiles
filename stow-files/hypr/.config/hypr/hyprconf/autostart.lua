local terminal = "ghostty"
local fileManager = "thunar"
local menu = "rofi"

h1.on("hyprland.start", function()
    h1.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway DISPLAY && sleep 1 && systemctl --user start xdg-desktop-portal-gtk xdg-desktop-portal")
    h1.exec_cmd("waybar")
    h1.exec_cmd("awww-daemon")
    h1.exec_cmd("copyq --start-server")
    h1.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    h1.exec_cmd("/usr/lib/gcr-ssh-agent")
    h1.exec_cmd("swayidle -w before-sleep 'swaylock -f'")
end)
