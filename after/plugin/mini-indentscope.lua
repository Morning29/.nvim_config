require("mini.indentscope").setup({
    -- symbol = "│",
    symbol = "⬝",
    draw = { animation = require("mini.indentscope").gen_animation.none(), },
    mappings = {
        -- Textobjects
        object_scope = "hi",
        object_scope_with_border = "hI",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[i",
        goto_bottom = "]i",
    },
})
