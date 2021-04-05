vim.o.termguicolors = true

-- colors for active , inactive buffer tabs
require "bufferline".setup {
    options = {
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 25,
        max_prefix_length = 25,
        -- tab_size = 28,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = false,
        separator_style = "slant",
        show_close_icon = false
    }
}

local opt = {silent = true}


-- move buffers
vim.api.nvim_set_keymap("n", "<M-S-L>", [[<Cmd>BufferLineMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<M-S-H>", [[<Cmd>BufferLineMovePrev<CR>]], opt)

-- change buffers
vim.api.nvim_set_keymap("n", "[b", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "b]", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
