-- for lsp_lines, show only when hovering
-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.config({ virtual_lines = { only_current_line = true } })]]
-- local AAA
vim.diagnostic.config({virtual_lines = false})

-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.config({ virtual_lines = { only_current_line = true } })]]

local timer = vim.loop.new_timer()

vim.api.nvim_create_autocmd(
  "CursorHold",
  {
    callback = function()
      vim.diagnostic.config({virtual_lines = false})
      timer:start(
        500,
        0,
        vim.schedule_wrap(
          function()
            vim.diagnostic.config({virtual_lines = {only_current_line = true}})
          end
        )
      )
    end
  }
)
-- this makes cursor to stop when holding j/k, disabling this for now
-- vim.api.nvim_create_autocmd(
--   "CursorMoved",
--   {
--     callback = function()
--       timer:stop()
--       vim.diagnostic.config({virtual_lines = false})
--     end
--   }
-- )
