-- Neovim 0.11 only auto-enables treesitter highlight for a handful of bundled
-- filetypes (lua, markdown, help, query). For everything else we start it
-- explicitly on FileType if an installed parser exists.
-- js/jsx/ts/tsx all use the tsx parser (superset that understands JSX nodes).
local js_fts = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" then return end

    local max_filesize = 200 * 1024 -- 200 KB
    local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok_stat and stats and stats.size > max_filesize then return end

    if js_fts[ft] then
      -- force tsx parser for all js/jsx/ts/tsx buffers
      pcall(vim.treesitter.start, args.buf, "tsx")
    else
      -- start treesitter only if a parser is available for this filetype
      local lang = vim.treesitter.language.get_lang(ft)
      if lang and pcall(vim.treesitter.language.inspect, lang) then
        pcall(vim.treesitter.start, args.buf)
      end
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

-- nvim-ts-autotag: auto-close and auto-rename HTML/JSX tags (replaces vim-closetag)
require("nvim-ts-autotag").setup()

-- for sticky scrolling
require("treesitter-context").setup {
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
  zindex = 20,
  on_attach = nil
}

-- quickly jump to previous context
vim.keymap.set(
  "n",
  ";",
  function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end,
  {silent = true}
)
