require("rules.fixes")
require("rules.popups")

hl.window_rule({
    name = "browser-workspace",
    match = {
        class = "firefox"
    },

    workspace = 1
})

hl.window_rule({
    name = "special-workspace",
    match = {
        workspace = "name:special:magic"
    },

    border_color = COLORS.second
})
