-- nvim config path to variable for windows support
vim.cmd("let $NVIMPATH = fnamemodify($MYVIMRC, ':p:h')")
local nvimrc = os.getenv("NVIMPATH")

-- lua config
require("general/mappings")
require("general/plugins")
local func = require("general/functions")

-- load colorscheme
require("plug-config/gruvbox")

-- vim general config
vim.cmd("source" .. nvimrc .. "/general/functions.vim")
-- vim.cmd("source" .. nvimrc .. "/general/mappings.vim")
vim.cmd("source" .. nvimrc .. "/general/settings.vim")

-- lsp
require("plug-config/lspconfig")

require("plug-config/luasnip")
require("plug-config/nvim-cmp")
require("plug-config/blankline")
require("plug-config/bufferline")
require("plug-config/codewindow")
require("plug-config/formatter")
require("plug-config/gitsigns")
require("plug-config/lualine")
require("plug-config/neoscroll")
require("plug-config/neo-tree")
-- require("plug-config/nvim-tree")
require("plug-config/nvim-ts-context-commentstring")
require("plug-config/scrollbar")
require("plug-config/telescope")
require("plug-config/treesitter")
require("plug-config/which-key")
require("plug-config/lsp_lines")
require("plug-config/dap")
require("plug-config/ts-node-action")
require("plug-config/barbecue")

-- source $NVIMPATH/general/plugins.vim

-- Plugins
-- vim.cmd("source" .. nvimrc .. "/plug-config/which-key.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/fzf.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/prettier.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/coc.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/tagalong.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/floatterm.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vimlesscss.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/quickscope.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/highlightedyank.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/visual-multi.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/closetag.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/tmux-navigator.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/git-messenger.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/go.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vimwiki.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/suda.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vista.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vcoolor.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/rooter.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/copilot.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vim-oscyank.vim")

print(nvimrc)
if vim.fn.filereadable(nvimrc .. "/dadbod.vim") == 1 then
  vim.cmd("source" .. nvimrc .. "/dadbod.vim")
end

-- server settings
func.ServerfixCommandIfFileExists()
