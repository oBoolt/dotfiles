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
        local n = name:sub(1, 1):upper() .. name:sub(2)
        OSD(1, n)
    else
        OSD(1, "Global")
    end
end)
