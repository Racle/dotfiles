local M = {}

function M.ServerfixCommandIfFileExists()
  if vim.fn.filereadable(os.getenv("NVIMPATH") .. "/server-init.vim") == 1 then
    vim.keymap.set("n", "<leader>ä", ":source " .. os.getenv("NVIMPATH") .. "/server-init.vim", {silent = true, noremap = true, expr = true})
  end
end

return M
