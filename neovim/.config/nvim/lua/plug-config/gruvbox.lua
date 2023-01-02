require("gruvbox").setup(
  {
    italic = false
  }
)
vim.cmd("colorscheme gruvbox")

-- lightspeed color fix
vim.cmd("highlight LightspeedShortcut guibg=#fabd2f guifg=#000000 gui=bold")
