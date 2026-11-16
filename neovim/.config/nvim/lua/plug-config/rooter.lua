-- Set the working directory to the project root on BufEnter (replaces vim-rooter).
-- VCS markers anywhere above the file win over a nearer Makefile; the Makefile
-- is only used when the file is not inside a repository. Toggle with :RooterToggle.
local markers = { { ".git", "_darcs", ".hg", ".bzr", ".svn" }, "Makefile" }
local enabled = true

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("auto_root", { clear = true }),
  callback = function(args)
    if not enabled or vim.bo[args.buf].buftype ~= "" then
      return
    end
    local root = vim.fs.root(args.buf, markers)
    if root and root ~= vim.fn.getcwd() then
      vim.fn.chdir(root)
    end
  end,
})

vim.api.nvim_create_user_command("RooterToggle", function()
  enabled = not enabled
  vim.notify("Auto root " .. (enabled and "enabled" or "disabled"))
end, { desc = "Toggle automatic project root" })
