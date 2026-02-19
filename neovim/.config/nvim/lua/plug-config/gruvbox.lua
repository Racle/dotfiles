-- if server-init exist then use it, else use the default
-- juicessh doesn't support gruvbox.nvim very well

if os.getenv("IS_SERVER") ~= "1" then
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
end
vim.cmd("colorscheme gruvbox")

-- markdown heading markers (## / ###) should be muted, not the same as heading text
vim.api.nvim_set_hl(0, "@punctuation.special.markdown", { fg = "#928374" })

-- lightspeed color fix
vim.cmd("highlight LightspeedShortcut guibg=#fabd2f guifg=#000000 gui=bold")

-- lighter background for non active windows
vim.cmd("highlight NormalNC guibg=#2B2B2B")
