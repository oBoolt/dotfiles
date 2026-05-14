local mainMod = "SUPER"

local terminal = "alacritty"
local browser = "firefox"
local fileManager = "nautilus"

local launch = function(app)
    return "uwsm app -- $(" .. app .. ")"
end

local wofi = function(app)
    return "pkill wofi || " .. launch(app)
end

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Z", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Wofi
hl.bind(mainMod .. " + SPACE",
    hl.dsp.exec_cmd(wofi("wofi --show drun --define=drun-print_desktop_file=true | sed -E \"s/(\\.desktop) /\\1:/\"")))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(wofi("rofimoji")))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(wofi("cliphist list | wofi --dmenu | cliphist decode | wl-copy")))

-- Universal Copy / Paste
hl.bind(mainMod .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }))
hl.bind(mainMod .. " + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))
hl.bind(mainMod .. " + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }))

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(launch(terminal)))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(launch(browser)))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(launch(fileManager)))

-- Change active window with arrows
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" }), { submap_universal = true })
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }), { submap_universal = true })
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" }), { submap_universal = true })
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "down" }), { submap_universal = true })

-- Change active window with vim keybinds
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { submap_universal = true })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { submap_universal = true })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), { submap_universal = true })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), { submap_universal = true })

-- Change window in layout
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.layout("swapsplit"))

-- Special Workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", function()
    local current = hl.get_active_window()
    if current ~= nil and current.workspace.special then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace().name }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "special:magic" }))
    end
end)

-- Resize
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("LEFT", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("RIGHT", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("UP", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("DOWN", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- use "0" for tenth workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("qs ipc call brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("qs ipc call brightness decrease"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Shell related binds
hl.bind("ESCAPE", hl.dsp.global("dotfiles:closePopups"), { non_consuming = true })
hl.bind(mainMod .. " + Y", hl.dsp.global("dotfiles:toggleMpris"))
hl.bind("RETURN", hl.dsp.global("dotfiles:togglePlaying"), { non_consuming = true })
hl.bind("RIGHT", hl.dsp.global("dotfiles:nextTrack"), { non_consuming = true })
hl.bind(mainMod .. " + RIGHT", hl.dsp.global("dotfiles:nextClient"))
hl.bind("LEFT", hl.dsp.global("dotfiles:previousTrack"), { non_consuming = true })
hl.bind(mainMod .. " + LEFT", hl.dsp.global("dotfiles:previousClient"))
hl.bind(mainMod .. " + P", hl.dsp.global("dotfiles:fullScreenshot"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.global("dotfiles:areaScreenshot"))
