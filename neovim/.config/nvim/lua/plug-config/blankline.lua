vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true

vim.g.indent_blankline_filetype_exclude = {"help", "terminal"}
vim.g.indent_blankline_buftype_exclude = {"terminal"}

-- default : {'class', 'function', 'method'}
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "^if",
  "^while",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments"
}
