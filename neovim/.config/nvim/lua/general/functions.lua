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

  local formatted = 0
  for _, file in ipairs(staged) do
    local filepath = git_root .. "/" .. file
    local bufnr = vim.fn.bufadd(filepath)
    vim.fn.bufload(bufnr)
    local ok, err = require("conform").format({bufnr = bufnr, async = false, timeout_ms = 5000})
    if ok then
      vim.api.nvim_buf_call(
        bufnr,
        function()
          vim.cmd("silent update")
        end
      )
      formatted = formatted + 1
    else
      vim.notify("Failed to format " .. file .. ": " .. tostring(err), vim.log.levels.WARN)
    end
  end

  vim.notify("Formatted " .. formatted .. "/" .. #staged .. " staged files", vim.log.levels.INFO)
end

function M.FormatQuickfixFiles()
  local qflist = vim.fn.getqflist()
  if #qflist == 0 then
    vim.notify("Quickfix list is empty", vim.log.levels.INFO)
    return
  end

  local seen = {}
  local buffers = {}
  for _, entry in ipairs(qflist) do
    if entry.bufnr and entry.bufnr > 0 and not seen[entry.bufnr] then
      seen[entry.bufnr] = true
      table.insert(buffers, entry.bufnr)
    end
  end

  if #buffers == 0 then
    vim.notify("No valid files in quickfix list", vim.log.levels.INFO)
    return
  end

  local formatted = 0
  for _, bufnr in ipairs(buffers) do
    vim.fn.bufload(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    local ok, err = require("conform").format({bufnr = bufnr, async = false, timeout_ms = 5000})
    if ok then
      vim.api.nvim_buf_call(
        bufnr,
        function()
          vim.cmd("silent update")
        end
      )
      formatted = formatted + 1
    else
      vim.notify("Failed to format " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
    end
  end

  vim.notify("Formatted " .. formatted .. "/" .. #buffers .. " quickfix files", vim.log.levels.INFO)
end

function M.Messages()
  vim.cmd("lua Snacks.notifier.show_history()")
end

vim.api.nvim_create_user_command("FormatStagedFiles", M.FormatStagedFiles, {})
vim.api.nvim_create_user_command("FormatQuickfixFiles", M.FormatQuickfixFiles, {})
vim.api.nvim_create_user_command("Messages", M.Messages, {})

return M
