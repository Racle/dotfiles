local M = {}

function M.ServerfixCommandIfFileExists()
  if os.getenv("IS_SERVER") == "1" then
    vim.keymap.set("n", "<leader>ä", ":source " .. os.getenv("NVIMPATH") .. "/server-init.vim<CR>", {silent = true, noremap = true})
  end
end

function M.FormatStagedFiles()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  local staged = vim.fn.systemlist("git diff --cached --name-only --diff-filter=d")
  if vim.v.shell_error ~= 0 or #staged == 0 then
    vim.notify("No staged files found", vim.log.levels.INFO)
    return
  end

  local qf_entries = {}
  for _, file in ipairs(staged) do
    table.insert(qf_entries, {filename = git_root .. "/" .. file})
  end

  vim.fn.setqflist(qf_entries)
  vim.cmd("copen")
  vim.cmd("cfdo lua require('conform').format({ bufnr = vim.api.nvim_get_current_buf() })")
  vim.cmd("cfdo update")
end

function M.Messages()
  vim.cmd("lua Snacks.notifier.show_history()")
end

vim.api.nvim_create_user_command("FormatStagedFiles", M.FormatStagedFiles, {})
vim.api.nvim_create_user_command("Messages", M.Messages, {})

return M
