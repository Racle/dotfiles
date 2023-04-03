local M = {}

function M.ServerfixCommandIfFileExists()
  if os.getenv("IS_SERVER") == "1" then
    vim.keymap.set("n", "<leader>ä", ":source " .. os.getenv("NVIMPATH") .. "/server-init.vim<CR>", {silent = true, noremap = true})
  end
end

return M
