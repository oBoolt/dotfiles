-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd(RUN("wl-paste --type text --watch cliphist store"));
    hl.exec_cmd(RUN("wl-paste --type image --watch cliphist store"));
    hl.exec_cmd(RUN("udiskie -a -n -t"));
    hl.exec_cmd(RUN("qs"));
    hl.exec_cmd(RUN("hyprlauncher -d"))
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-- Submap
hl.on("keybinds.submap", function(name)
    if name and name ~= '' then
        hl.exec_cmd("notify-send -u normal 'Submap changed' 'You are now at " .. name .. " submap'")
    else
        hl.exec_cmd("notify-send -u low 'Submap changed' 'Global submap'")
    end
end)
