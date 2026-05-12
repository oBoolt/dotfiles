require("rules.fixes")
require("rules.popups")

hl.window_rule({
    name = "browser-workspace",
    match = {
        class = "firefox"
    },

    workspace = 1
})
