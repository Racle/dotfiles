-- better 0 (goes start of line/first character)
local goToFirstCharOrLineRegex = "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'"
vim.api.nvim_set_keymap("v", "0", goToFirstCharOrLineRegex, {silent = true, noremap = true, expr = true})
vim.api.nvim_set_keymap("n", "0", goToFirstCharOrLineRegex, {silent = true, noremap = true, expr = true})

vim.api.nvim_set_keymap("n", [[<A-h>]], "<cmd>lua require('utils').resize(true, -2)<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", [[<A-l>]], "<cmd>lua require('utils').resize(true, 2)<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", [[<A-k>]], "<cmd>lua require('utils').resize(false, -2)<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", [[<A-j>]], "<cmd>lua require('utils').resize(false, 2)<CR>", {silent=true, noremap=true})
