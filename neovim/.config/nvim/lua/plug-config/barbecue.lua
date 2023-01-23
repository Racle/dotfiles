vim.api.nvim_create_autocmd(
  {
    "WinScrolled",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    -- include these if you have set `show_modified` to `true`
    "BufWritePost",
    "TextChanged",
    "TextChangedI"
  },
  {
    group = vim.api.nvim_create_augroup("barbecue#create_autocmd", {}),
    callback = function()
      require("barbecue.ui").update()
    end
  }
)
