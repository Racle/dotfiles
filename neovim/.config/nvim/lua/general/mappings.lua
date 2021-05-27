-- better 0 (goes start of line/first character)
vim.api.nvim_set_keymap(
  "v",
  "0",
  "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
  {silent = true, noremap = true, expr = true}
)
vim.api.nvim_set_keymap(
  "n",
  "0",
  "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
  {silent = true, noremap = true, expr = true}
)
