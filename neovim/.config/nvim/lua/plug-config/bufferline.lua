vim.o.termguicolors = true

require "bufferline".setup {
    highlights = {
        fill = {
            guibg = "#282828"
        },
        separator_selected = {
            guifg = "#282828"
        },
        separator_visible = {
            guifg = "#282828"
        },
        separator = {
            guifg = "#282828"
        }
    },
    options = {
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 25,
        max_prefix_length = 25,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "slant"
    }
}

local opt = {silent = true}

-- move buffers
vim.api.nvim_set_keymap("n", "<M-S-L>", [[<Cmd>BufferLineMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<M-S-H>", [[<Cmd>BufferLineMovePrev<CR>]], opt)

-- change buffers
vim.api.nvim_set_keymap("n", "[b", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "b]", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
