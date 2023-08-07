local gitsigns = require "gitsigns"

vim.o.termguicolors = true

gitsigns.setup {
  -- keymaps = {
  --   buffer = true,
  --   ['n ]c'] = '<cmd>lua require"gitsigns".next_hunk({wrap = true})<CR>',
  --   ['n [c'] = '<cmd>lua require"gitsigns".prev_hunk({wrap = true})<CR>',
  -- },
  max_file_length = 100000
}
