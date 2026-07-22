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
    name = "discord-workspace",
    match = {
        class = "discord"
    },

    workspace = 3
})

hl.window_rule({
    name = "spotify-workspace",
    match = {
        class = "Spotify"
    },

    workspace = 3
})

hl.window_rule({
    name = "steam-workspace",
    match = {
        class = "steam"
    },

    workspace = 4
})

hl.window_rule({
    name = "spotify-workspace",
    match = {
        class = "Spotify"
    },

    workspace = 5
})

hl.window_rule({
    name = "special-workspace",
    match = {
        workspace = "name:special:magic"
    },

    border_color = COLORS.second
})

hl.window_rule({
    name = "games-workspace",
    match = {
        class = "steam_app_.*"
    },

    workspace = "special:magic"
})
