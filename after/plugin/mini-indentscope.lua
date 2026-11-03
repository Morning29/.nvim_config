require("mini.indentscope").setup({
    symbol = "⬝",
    draw = { animation = require("mini.indentscope").gen_animation.none(), },
    mappings = {
        -- Text objects
        object_scope = "hs",
        object_scope_with_border = "as",
        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[s",
        goto_bottom = "]s",
    },
})
