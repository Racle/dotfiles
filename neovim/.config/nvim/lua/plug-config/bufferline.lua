vim.o.termguicolors = true

-- tilix fix for https://github.com/akinsho/nvim-bufferline.lua/issues/125 / https://github.com/akinsho/nvim-bufferline.lua/commit/54576f262e4ef5ea7a31d88b2d1399f637e338d2
vim.api.nvim_exec([[let $KITTY_WINDOW_ID=0]], true)

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
    separator_style = "slant",
    offsets = {
      {
        filetype = "coc-explorer",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}

local opt = {silent = true}

-- move buffers
vim.api.nvim_set_keymap("n", "<M-S-L>", [[<Cmd>BufferLineMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<M-S-H>", [[<Cmd>BufferLineMovePrev<CR>]], opt)

-- change buffers
vim.api.nvim_set_keymap("n", "[b", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "b]", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

-- pick buffer
vim.api.nvim_set_keymap("n", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
vim.api.nvim_set_keymap("v", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
