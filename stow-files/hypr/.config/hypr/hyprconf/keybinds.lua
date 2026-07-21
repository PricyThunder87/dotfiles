local browser = "firefox"
local fileManager = "thunar"
local menu = "rofi -show drun -show-icons -font \"IoskeleyMono Nerd Font 12\""
local terminal = "ghostty"

hl.config({
    input = {
        kb_layout  = "us",

        follow_mouse = 0,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Apps
hl.bind("SUPER+Return", hl.dsp.exec_cmd(terminal), { description = "Open terminal" })
hl.bind("SUPER+E", hl.dsp.exec_cmd(fileManager), { description = "Open file manager" })
hl.bind("SUPER+B", hl.dsp.exec_cmd(browser), { description = "Open browser" })
hl.bind("SUPER+D", hl.dsp.exec_cmd(menu), { description = "App launcher" })
hl.bind("SUPER+SHIFT+R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload config" })

-- Kill / reload / exit
hl.bind("SUPER+Q", hl.dsp.window.close(), { description = "Kill window" })
hl.bind("SUPER+SHIFT+C", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload config" })
hl.bind("SUPER+SHIFT+E", hl.dsp.exec_cmd("hyprctl dispatch exit"), { description = "Exit Hyprland" })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grimshot copy area"), { description = "Screenshot area" })
hl.bind("SUPER+Print", hl.dsp.exec_cmd("grimshot copy active"), { description = "Screenshot active window" })

-- Lock screen
hl.bind("SUPER+SHIFT+CTRL+L", hl.dsp.exec_cmd("swaylock -f"), { description = "Lock screen" })

-- Window focus (vim keys)
hl.bind("SUPER+H", hl.dsp.focus({direction = "left"  }),    { description = "Focus left" })
hl.bind("SUPER+J", hl.dsp.focus({direction = "down"  }),    { description = "Focus down" })
hl.bind("SUPER+K", hl.dsp.focus({direction = "up"    }),    { description = "Focus up" })
hl.bind("SUPER+L", hl.dsp.focus({direction = "right" }),    { description = "Focus right" })

hl.bind("SUPER+mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window focus (arrow keys)
hl.bind("SUPER+Left",  hl.dsp.focus({direction = "left"  }), { description = "Focus left" })
hl.bind("SUPER+Down",  hl.dsp.focus({direction = "down"  }), { description = "Focus down" })
hl.bind("SUPER+Up",    hl.dsp.focus({direction = "up"    }), { description = "Focus up" })
hl.bind("SUPER+Right", hl.dsp.focus({direction = "right" }), { description = "Focus right" })

-- Move windows (vim keys) - FIXED DIRECTIONS
hl.bind("SUPER+SHIFT+H", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind("SUPER+SHIFT+J", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })
hl.bind("SUPER+SHIFT+K", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind("SUPER+SHIFT+L", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })

-- Move windows (arrow keys)
hl.bind("SUPER+SHIFT+Left",  hl.dsp.window.move({direction = "l"  }), { description = "Move window left" })
hl.bind("SUPER+SHIFT+Down",  hl.dsp.window.move({direction = "d"  }), { description = "Move window down" })
hl.bind("SUPER+SHIFT+Up",    hl.dsp.window.move({direction = "u"    }), { description = "Move window up" })
hl.bind("SUPER+SHIFT+Right", hl.dsp.window.move({direction = "r" }), { description = "Move window right" })

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER+" .. key,       hl.dsp.focus({workspace = i}),                             { description = "Go to workspace " .. i })
    hl.bind("SUPER+SHIFT+" .. key, hl.dsp.exec_cmd("hyprctl dispatch movetoworkspace " .. i), { description = "Move window to workspace " .. i })
end

-- Scratchpad
hl.bind("SUPER+S", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Toggle scratchpad" })
hl.bind("SUPER+SHIFT+S", hl.dsp.window.move({ workspace = "special:scratchpad" }), { description = "Move window to scratchpad" } )

-- Layout / floating
hl.bind("SUPER+F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind("SUPER+SHIFT+Space", hl.dsp.window.float(), { description = "Toggle floating" })
hl.bind("SUPER+Space", hl.dsp.window.cycle_next(), { description = "Cycle windows" })

-- Media keys
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),       { locked = true, description = "Mute audio" })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),        { locked = true, description = "Volume down" })
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),        { locked = true, description = "Volume up" })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),   { locked = true, description = "Mute mic" })
hl.bind("XF86AudioPlay",          hl.dsp.exec_cmd("playerctl play-pause"),                             { locked = true, description = "Play/pause" })
hl.bind("XF86AudioNext",          hl.dsp.exec_cmd("playerctl next"),                                   { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev",          hl.dsp.exec_cmd("playerctl previous"),                               { locked = true, description = "Previous track" })

-- Brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, description = "Brightness down" })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, description = "Brightness up" })
