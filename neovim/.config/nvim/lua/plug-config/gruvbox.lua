require("gruvbox").setup(
  {
    italic = {
      strings = false,
      comments = false,
      operators = false,
      folds = true
    }
  }
)
vim.cmd("colorscheme gruvbox")

-- lightspeed color fix
vim.cmd("highlight LightspeedShortcut guibg=#fabd2f guifg=#000000 gui=bold")

-- lighter background for non active windows
vim.cmd("highlight NormalNC guibg=#2B2B2B")
