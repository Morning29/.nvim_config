require('telescope').setup({
    defaults = {
        -- path_display = { "absolute" },
        layout_strategy = 'flex',
        layout_config = {
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.8
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 190,
                prompt_position = "bottom",
                width = 0.8
            },
        },
        dynamic_preview_title = true,
        results_title = false,
        preview_title = false,
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }, -- { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        selection_caret = '  ',
        file_ignore_patterns = {
            "[\\/]nvidia_samples[\\/]", -- TODO 12/05/26 HSU: Somehow make these local to the relevant projects.
            "^%.git[\\/]",
            "[\\/]%.git[\\/]",
            "^%.vs[\\/]",
            "[\\/]%.vs[\\/]",
            "%.bin$",
            "%.dds$",
            "%.exe$",
            "%.ggb$",
            "%.glb$",
            "%.gltf$",
            "%.lib$",
            "%.dll$",
            "%.exp$",
            "%.log$",
            "%.mtl$",
            "%.obj$",
            "%.pdb$",
            "%.png$",
            "%.rad$",
            "%.rdi$",
            "%.spv$",
            "%.spv%-asm$",
            "%.tracy$",
            "%.ttf$",
            "%.zip$",
        },
    },
    pickers = {
        -- lsp_definitions = { fname_width = 60 },
        find_files = {
            hidden = true,
        },
        diagnostics = {
        },
    }
})

do -- Keymaps
    local builtin = require('telescope.builtin')

    --- Treat selecting a diagnostic as a vim.diagnostic.jump, which will execute on_jump etc.
    ---@param workspace? boolean
    ---@param bufnr? integer
    ---@param severity_limit? vim.diagnostic.Severity
    local pick_diagnostics_and_jump_to_selection = function(workspace, bufnr, severity_limit)
        local opts = {
            workspace = workspace or false,
            bufnr = bufnr or nil,
            severity_limit = severity_limit or nil,
            attach_mappings = function(prompt_bufnr, _)
                require('telescope.actions').select_default:replace(function()
                    require('telescope.actions.set').select(prompt_bufnr, "default")
                    local selection = require('telescope.actions.state').get_selected_entry()
                    if not selection then
                        return
                    end

                    local diags = vim.diagnostic.get(selection.value.bufnr, { lnum = selection.lnum - 1 })
                    if #diags < 1 then
                        return
                    end

                    local diag = diags[1]
                    for _, line_diag in ipairs(diags) do
                        -- NOTE 03/11/26 HSU: vim.diagnostic and telescope have different views on column numbers...
                        if line_diag.col == selection.col - 1 then
                            -- NOTE 03/11/26 HSU: As far as I can tell, vim.diagnostic merges diagnostics at the same location.
                            -- But, in case of multiple diagnostics at the same position, this wouldn't actually necessarily
                            -- match the jumped to diagnostic with the selected one. It would just chooses the highest severity
                            -- diagnostic at the selected location.
                            if diag.col ~= line_diag.col or line_diag.severity < diag.severity then
                                diag = line_diag
                            end
                        end
                    end
                    if diag then
                        vim.schedule(function() vim.diagnostic.jump({ diagnostic = diag }) end)
                    end
                end)

                return true
            end,
        }

        builtin.diagnostics(opts)
    end

    --- @format disable
    vim.keymap.set('n', '<leader><F1>', function() pick_diagnostics_and_jump_to_selection(false, 0) end)
    vim.keymap.set('n', '<leader><F2>', function() pick_diagnostics_and_jump_to_selection(false, 0, vim.diagnostic.severity.WARN) end)
    vim.keymap.set('n', '<leader><F3>', function() pick_diagnostics_and_jump_to_selection(true) end)
    vim.keymap.set('n', '<leader><F4>', function() pick_diagnostics_and_jump_to_selection(true, nil, vim.diagnostic.severity.WARN) end)

    vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ no_ignore = true }) end)
    vim.keymap.set('n', '<leader>fF', builtin.git_files)
    vim.keymap.set('n', '<leader>fc', builtin.git_status)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags)
    vim.keymap.set('n', '<leader>fs', function() builtin.lsp_document_symbols({ symbol_width = 120 }) end)
    vim.keymap.set('n', '<leader>fS', function() builtin.lsp_dynamic_workspace_symbols({ fname_width = 40, symbol_width = 80 }) end)

    vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations)
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references)
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions)
    vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions)

    vim.keymap.set('n', '<leader>gci', builtin.lsp_incoming_calls)
    vim.keymap.set('n', '<leader>gco', builtin.lsp_outgoing_calls)
end

-- TODO 12/05/26 HSU: Make this not error when Harpoon isn't installed.
do -- Harpoon
    local harpoon = require('harpoon')

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    vim.keymap.set("n", "<leader>hmt", function() toggle_telescope(harpoon:list()) end)
end
