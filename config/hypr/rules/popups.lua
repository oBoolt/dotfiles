hl.window_rule({
    match = {
        tag = "popup"
    },

    float = true,
    center = true,
    border_size = 0,
})

hl.window_rule({
    match = {
        class = "org.gnome.Nautilus"
    },

    tag = "+popup",
    size = { "(monitor_w*0.75)", "(monitor_h*0.75)" }
})

hl.window_rule({
    match = {
        class = "steam",
        initial_title = "negative:Steam"
    },

    tag = "+popup"
})
