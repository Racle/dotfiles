local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    mappings = {
      n = {
        ["<C-q>"] = send_selected_to_qflist
      },
      i = {
        ["<C-q>"] = send_selected_to_qflist
      }
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
    prompt_position = "bottom",
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
        preview_width = 0.5
      },
      vertical = {
        mirror = false
      }
    },
    file_sorter = require "telescope.sorters".get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    use_less = true,
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    file_previewer = require "telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "pdf"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  }
}

require("telescope").load_extension("media_files")

local opt = {noremap = true, silent = true}

vim.g.mapleader = " "

-- mappings
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<leader>n", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fp",
  [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]],
  opt
)

vim.api.nvim_set_keymap("n", "<leader>fq", [[<Cmd>lua require('telescope.builtin').quickfix()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
