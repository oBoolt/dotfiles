hl.config({
    general = {
        layout = "dwindle",
        border_size = 2,
        gaps_in = 4,
        gaps_out = 8,
        col = {
            inactive_border = COLORS.background,
            active_border = COLORS.main,
            nogroup_border = COLORS.warning,
            nogroup_border_active = COLORS.second
        },
        allow_tearing = true,
    },
    decoration = {
        rounding = 3,
        dim_inactive = true,
        dim_strength = 0.15,
        blur = {
            enabled = false
        },
        shadow = {
            enabled = false
        }
    },
    dwindle = {
        preserve_split = true,
        force_split = 2
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 1,
        background_color = "#000000",
    }
})
