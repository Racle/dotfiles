-- Desc: Settings that are set after plugins are loaded

-- Treesitter-context highlights/underline
vim.cmd [[ hi TreesitterContextBottom gui=underline guisp=#665c54 ]]
vim.cmd [[ hi TreesitterContextLineNumberBottom gui=underline guisp=#665c54 ]]

-- Dropbar highlights
vim.cmd [[hi WinBar guisp=#665c54 gui=underline guibg=#313131]]
