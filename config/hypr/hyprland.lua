local dotfiles_path = os.getenv("DOTFILES_PATH")
if dotfiles_path then
    package.path = dotfiles_path .. "/?.lua;" .. package.path
end

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

COLORS = {
    main = "#00ffff",
    second = "#ff0000",
    background = "#000000",
    foreground = "#ffffff",
    warning = "#fabd2f"
}

do
    local file = io.open(dotfiles_path .. "/themes/current/hypr.lua", "r")
    if file then
        file:close()
        COLORS = require("themes.current.hypr")
    end
end

function RUN(app)
    return "runapp " .. app
end

function NOTIFY(summary, body, urgency)
    local u = urgency or "normal"
    local b = body or ""
    hl.exec_cmd("notify-send -a dotfiles -u " .. u .. " '" .. summary .. "' '" .. b .. "'")
end

function OSD(icon, text)
    local i = icon or 0
    local t = text or ""
    hl.exec_cmd("qs ipc call osd showText " .. i .. " '" .. t .. "'")
end

require("modules")
require("rules")

do
    local file = io.open(dotfiles_path .. "/local/hypr.lua", "r")
    if file then
        file:close()
        require("local.hypr")
    end
end
