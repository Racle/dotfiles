-- Treesitter highlight and indent are built into Neovim 0.11+ and enabled by default.
-- Disable treesitter highlighting for large files.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local max_filesize = 200 * 1024 -- 200 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(args.buf)
    end
  end,
})

-- Textobjects (now configured through nvim-treesitter-textobjects directly)
-- Textobject selection keymaps
vim.keymap.set({"x", "o"}, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer") end, {desc = "Select outer function"})
vim.keymap.set({"x", "o"}, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner") end, {desc = "Select inner function"})
vim.keymap.set({"x", "o"}, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer") end, {desc = "Select outer class"})
vim.keymap.set({"x", "o"}, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner") end, {desc = "Select inner class"})

-- Textobject move keymaps
vim.keymap.set({"n", "x", "o"}, "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer") end, {desc = "Next function start"})
vim.keymap.set({"n", "x", "o"}, "]]", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer") end, {desc = "Next class start"})
vim.keymap.set({"n", "x", "o"}, "]M", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer") end, {desc = "Next function end"})
vim.keymap.set({"n", "x", "o"}, "][", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer") end, {desc = "Next class end"})
vim.keymap.set({"n", "x", "o"}, "[m", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer") end, {desc = "Previous function start"})
vim.keymap.set({"n", "x", "o"}, "[[", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer") end, {desc = "Previous class start"})
vim.keymap.set({"n", "x", "o"}, "[M", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer") end, {desc = "Previous function end"})
vim.keymap.set({"n", "x", "o"}, "[]", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer") end, {desc = "Previous class end"})

-- Incremental selection (using Neovim's built-in treesitter)
vim.keymap.set("n", "<M-w>", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
end, {desc = "Init treesitter selection"})

-- for sticky scrolling
require("treesitter-context").setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil -- (fun(buf: integer): boolean) return false to disable attaching
}

-- quickly ; to go to previous context
vim.keymap.set(
  "n",
  ";",
  function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end,
  {silent = true}
)

