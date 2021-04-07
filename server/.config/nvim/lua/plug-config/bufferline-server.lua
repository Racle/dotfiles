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
        separator_style = "thin",
    }
}
