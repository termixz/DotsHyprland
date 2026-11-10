hl.config({
    general = {
        border_size = 2,
        gaps_in = 2,
        gaps_out = 4,

        col = {
            active_border = "rgb(907aa9)",
            inactive_border = "rgb(f2e9e1)",
        },
    },

    decoration = {
        rounding = 10,

        active_opacity = 0.95,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 3,
            render_power = 1,
            color = "rgb(949186)",
            color_inactive = "rgb(6A675F)",
        },

        blur = {
            enabled = true,
            size = 2,
            passes = 3,
            ignore_opacity = true,
        },
    },

    group = {
        col = {
            border_active = "rgb(303644)",
            border_inactive = "rgb(303644)",
        },

        groupbar = {
            col = {
                active = "rgb(303644)",
                inactive = "rgb(303644)",
            },
        },
    },
})
