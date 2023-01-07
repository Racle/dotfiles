vim.o.termguicolors = true

require "bufferline".setup {
  highlights = {
    buffer_selected = {
      italic = false
    },
    fill = {
      bg = "#313131"
    },
    separator_selected = {
      fg = "#313131"
    },
    separator_visible = {
      fg = "#313131"
    },
    separator = {
      fg = "#313131"
    }
  },
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or ""
      return icon .. "" .. count
    end,
    -- custom_filter = function(buf_number, buf_numbers)
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
    end,
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
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      },
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}

-- bufferline ignore these
-- "dapui_watches",
-- "dapui_breakpoints",
-- "dapui_scopes",
-- "dapui_console",
-- "dapui_stacks",
-- "dap-repl"
local opt = {silent = true}

-- move buffers
vim.api.nvim_set_keymap("n", "<M-S-L>", [[<Cmd>BufferLineMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<M-S-H>", [[<Cmd>BufferLineMovePrev<CR>]], opt)

-- change buffers
vim.api.nvim_set_keymap("n", "<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

-- pick buffer
vim.api.nvim_set_keymap("n", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
vim.api.nvim_set_keymap("v", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
