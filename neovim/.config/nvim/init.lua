-- nvim config path to variable for windows support
vim.cmd("let $NVIMPATH = fnamemodify($MYVIMRC, ':p:h')")
local nvimrc = os.getenv("NVIMPATH")
vim.fn.setenv("IS_SERVER", vim.fn.filereadable(os.getenv("NVIMPATH") .. "/server-init.vim"))

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
require("plug-config/conform")
require("plug-config/lualine")
require("plug-config/neo-tree")
require("plug-config/nvim-ts-context-commentstring")
require("plug-config/telescope")
require("plug-config/which-key")
require("plug-config/lsp_lines")
require("plug-config/ts-node-action")
-- require("plug-config/lspsaga") -- replaced by native LSP + snacks.nvim

-- after installing lazy, you need to load colorscheme here again to make it work for some reason
vim.cmd("colorscheme gruvbox")
require("plug-config/dropbar")

-- to fix colorscheme issues after lazy
require("plug-config/leap")

-- Plugins
-- vim.cmd("source" .. nvimrc .. "/plug-config/which-key.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/fzf.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/prettier.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/coc.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/tagalong.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/floatterm.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vimlesscss.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/quickscope.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/highlightedyank.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/visual-multi.vim")
-- vim-closetag removed; nvim-ts-autotag handles tag closing
vim.cmd("source" .. nvimrc .. "/plug-config/git-messenger.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/go.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vimwiki.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/suda.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vista.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/vcoolor.vim")
vim.cmd("source" .. nvimrc .. "/plug-config/rooter.vim")
-- vim.cmd("source" .. nvimrc .. "/plug-config/copilot.vim")

if vim.fn.filereadable(nvimrc .. "/dadbod.vim") == 1 then
  vim.cmd("source" .. nvimrc .. "/dadbod.vim")
end

-- load certain config after plugins
require("general/settings-after")

-- server settings
func.ServerfixCommandIfFileExists()
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "fugitiveblame",
    callback = function()
      -- Save the current buffer and window
      local blame_buf = vim.api.nvim_get_current_buf()
      local original_win = vim.fn.win_getid(vim.fn.winnr("#")) -- Previous window

      -- Ensure original window is valid
      if original_win ~= 0 and vim.api.nvim_win_is_valid(original_win) then
        local ok, dropbar = pcall(require, "dropbar")

        -- Check if Dropbar is visible in the original window
        if ok and dropbar._current_win == original_win and vim.api.nvim_win_is_valid(dropbar._current_win) then
          local was_modifiable = vim.bo[blame_buf].modifiable

          -- Modify the blame buffer
          vim.bo[blame_buf].modifiable = true
          vim.api.nvim_buf_set_lines(blame_buf, 0, 1, false, {"Custom line added to fugitiveblame buffer"})
          vim.bo[blame_buf].modifiable = was_modifiable
        end
      end
    end
  }
)
