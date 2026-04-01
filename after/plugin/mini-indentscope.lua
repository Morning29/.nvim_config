require("mini.indentscope").setup({
    -- symbol = "│",
    symbol = "⬝",
    draw = { animation = require("mini.indentscope").gen_animation.none(), },
    mappings = {
        -- Textobjects
        object_scope = "hs",
        object_scope_with_border = "hS",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[s",
        goto_bottom = "]s",
    },
})
